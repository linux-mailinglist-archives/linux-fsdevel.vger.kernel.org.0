Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2552B55EB1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 19:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbiF1ReW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 13:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbiF1ReU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:34:20 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAC72CC86
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=glVNoDtxSftLtqxSLsKxMpvZX7IHQTZyd+zN49G4a3o=; b=wx4+yzySMe6CTX4UGnP8o+qFyp
        zgU3EXqx/LrNIcM0bO4OoABS3mlpLacBDJPAp/IBRWwPygOYP6FES6InjgGBgIJ3dweDa9Gkli17n
        fXCZnTwiefAdOoZDvh/8RyFVh0UFhKiP4I4DU5FPw+Q91dPV/hqXxD4VwVD0zHv8Y+GvNRrkTwsP2
        IwjVdXqiXTCXOyd7mWoJe4R1fIZcsEnaUITdDTqugroHEJz8NNE8O32sREyH3spQ3nwbara23Mahg
        fgFVgLZ3UBG4CekliLalp8VbxhJS+clMil/dmo/DzCNf2dsx6s71sFaoV+XUxQfPdftxtKi3rt0jU
        Opv4KUqw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o6F6M-005h6V-TA;
        Tue, 28 Jun 2022 17:34:15 +0000
Date:   Tue, 28 Jun 2022 18:34:14 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     James Yonan <james@openvpn.net>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] namei: implemented RENAME_NEWER flag for renameat2()
 conditional replace
Message-ID: <Yrs7lh6hG44ERoiM@ZenIV>
References: <20220627221107.176495-1-james@openvpn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627221107.176495-1-james@openvpn.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 27, 2022 at 04:11:07PM -0600, James Yonan wrote:

> 	    && d_is_positive(new_dentry)
> 	    && timespec64_compare(&d_backing_inode(old_dentry)->i_mtime,
> 				  &d_backing_inode(new_dentry)->i_mtime) <= 0)
> 		goto exit5;
> 
> It's pretty cool in a way that a new atomic file operation can even be
> implemented in just 5 lines of code, and it's thanks to the existing
> locking infrastructure around file rename/move that these operations
> become almost trivial.  Unfortunately, every fs must approve a new
> renameat2() flag, so it bloats the patch a bit.

How is it atomic and what's to stabilize ->i_mtime in that test?
Confused...
