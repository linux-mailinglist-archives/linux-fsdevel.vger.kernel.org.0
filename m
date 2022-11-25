Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D36638386
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 06:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiKYFgV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 00:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiKYFgU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 00:36:20 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D524B1F2E2;
        Thu, 24 Nov 2022 21:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/Fy8IK15qJEgUw8XxuI3itfGpmDfS+C65ciFIe4IOEs=; b=DJkkcB9+bPhlo5VEmHPEHPOJXO
        TYAZUlKV4rHswxZ0Cx6RrOzm0QRB9AOYhhnvj+b5UvoWy4ix+CpY09sDKezlqGCkSPSiueHH7XXXC
        VNLNgoPZAglozigfkez0BXchLSpnH3acekVgBZMcjI0gT6zexLKD0I8qLoX4tK5hb2e04mCm2aSkH
        Z8UkSY7YMcdZXhj28gpqcwE0sUJ7m2YrruZufQjF1Uk9rcFfu05mJ2GSAXpxG2+vq+EVHjS3jyTRk
        IRO/dPbSu5GRyT1c6fgEat+6jv1aY0UIT4Baux4543rh2UXCIChk3o7FIjm2hpfezf9PTZ/xeixEE
        xjX8k4SQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oyRNk-006bGd-1M;
        Fri, 25 Nov 2022 05:36:12 +0000
Date:   Fri, 25 Nov 2022 05:36:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Luis Henriques <lhenriques@suse.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        Luis Henriques <lhenriques@suse.de>
Subject: Re: [PATCH v2] vfs: fix copy_file_range() averts filesystem freeze
 protection
Message-ID: <Y4BUTK/pJAbBkUkW@ZenIV>
References: <20221117205249.1886336-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117205249.1886336-1-amir73il@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 17, 2022 at 10:52:49PM +0200, Amir Goldstein wrote:
> Commit 868f9f2f8e00 ("vfs: fix copy_file_range() regression in cross-fs
> copies") removed fallback to generic_copy_file_range() for cross-fs
> cases inside vfs_copy_file_range().
> 
> To preserve behavior of nfsd and ksmbd server-side-copy, the fallback to
> generic_copy_file_range() was added in nfsd and ksmbd code, but that
> call is missing sb_start_write(), fsnotify hooks and more.
> 
> Ideally, nfsd and ksmbd would pass a flag to vfs_copy_file_range() that
> will take care of the fallback, but that code would be subtle and we got
> vfs_copy_file_range() logic wrong too many times already.
> 
> Instead, add a flag to explicitly request vfs_copy_file_range() to
> perform only generic_copy_file_range() and let nfsd and ksmbd use this
> flag only in the fallback path.
> 
> This choise keeps the logic changes to minimum in the non-nfsd/ksmbd code
> paths to reduce the risk of further regressions.
> 
> Fixes: 868f9f2f8e00 ("vfs: fix copy_file_range() regression in cross-fs copies")
> Tested-by: Namjae Jeon <linkinjeon@kernel.org>
> Tested-by: Luis Henriques <lhenriques@suse.de>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Applied...
