Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E882E7BD3B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 08:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345326AbjJIGnq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 02:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345255AbjJIGno (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:43:44 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C92A4;
        Sun,  8 Oct 2023 23:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=66cPIIVSduT4SSzIFKFV2DdYfGERM4AlNBtZs6GbMmQ=; b=iHedBYMXz122Rt3NMtdmIGM0Pk
        5HyyqA4crg9PBCwe84Lle5UlQE2aiAjPubk1C70vZYY/jMoNvTg4DrO6S0Ag4avKDof6GqiqdEyLi
        xxXypPlmj4Gx3nbETKdhOj718ai6Xw5oIpTG4eVPccohWBRp4wdwaDTxE5EhDh13ENMYAkpTXb9NB
        vXsZVPIWmPyPt4s/+4zlr0HIVOud8V83+ZoSbMslRJqq6mV1Vzz8Z+ctCaZrTelmTC0mLVRjh4Oip
        bGnYphim7kJa6eav2x0Eo7JuPKSGT9zas2OkJHx7wbcSo56qcgQ/T84j8TMzKf5oqgN20E+VLRdfe
        4jML5x1g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qpjzG-00H7PN-32;
        Mon, 09 Oct 2023 06:43:31 +0000
Date:   Mon, 9 Oct 2023 07:43:30 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fs: get mnt_writers count for an open backing
 file's real path
Message-ID: <20231009064330.GF800259@ZenIV>
References: <20231007084433.1417887-1-amir73il@gmail.com>
 <20231007084433.1417887-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007084433.1417887-2-amir73il@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 07, 2023 at 11:44:31AM +0300, Amir Goldstein wrote:
> +static inline void file_put_write_access(struct file *file)
> +{
> +	put_write_access(file->f_inode);
> +	mnt_put_write_access(file->f_path.mnt);
> +	if (unlikely(file->f_mode & FMODE_BACKING)) {
> +		struct path *real_path = backing_file_real_path(file);
> +
> +		if (real_path->mnt)
> +			mnt_put_write_access(real_path->mnt);

IDGI.  Where do we get FMODE_BACKING combined with NULL real_path.mnt *AND*
put_file_access() possibly called?  Or file_get_write_access(), for
that matter...

FMODE_BACKING is set only in alloc_empty_backing_file().  The only caller
is backing_file_open(), which immediately sets real_path to its third
argument.  That could only come from ovl_open_realfile().  And if that
had been called with buggered struct path, it would have already blown
up on mnt_idmap(realpath->mnt).

The only interval where such beasts exist is from
        ff->file.f_mode |= FMODE_BACKING | FMODE_NOACCOUNT;
	return &ff->file;
in alloc_empty_backing_file() through

	f->f_path = *path;
	path_get(real_path);
	*backing_file_real_path(f) = *real_path;

in backing_file_open().  Where would that struct file (just allocated,
never seen outside of local variables in those two scopes) be passed
to get_file_write_access() or put_file_access()?

Or am I misreading something?
