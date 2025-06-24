Return-Path: <linux-fsdevel+bounces-52774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BB9AE66DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 15:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30CA418816AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 13:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B64B2C158E;
	Tue, 24 Jun 2025 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aD+wVHDF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A4B2C159A;
	Tue, 24 Jun 2025 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772586; cv=none; b=Wz91k6QDeGz8tdVmKInxWSIwgckxID9LAhcM5oEsne/mpnJ6tIs1MhFliorcviXWOBnrviPVnE/b7aaVrmcWDa/TpQdOvmAdw8kGiyc5RjpPNMe5jeZQZao2gI8J0U3TWCrGiVTwKH2oAcWvgw3gYwFAZ2g/GDjyULMsuK46kB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772586; c=relaxed/simple;
	bh=2gH2VoQsiALAGzhMMUusR6242xTO4xYRWRFbeHfpFng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nt2up9+exgV4+v2JumyuTJZW5DAjQ+RGOSWswALGQ91ZUdN+ncT1YFiovjc3dV1nUkz86OkFKrtpxHST5iajW1PrxB9PaCqnbfC+gj1aJuEyx7v2auXjFbqrEb7vszr1nz36kmg5DrjXHpvaGjhxM9ICt+oZ17EQp11O6UIuxlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aD+wVHDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330F0C4CEEE;
	Tue, 24 Jun 2025 13:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750772585;
	bh=2gH2VoQsiALAGzhMMUusR6242xTO4xYRWRFbeHfpFng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aD+wVHDFNAx7X9915mikLhwd7wSRv/FgsA4ywSqPZqSj0DAE7Kj4moHNbjXUBlcfJ
	 IydOtV+jW9GWhat7NEdEyxaozm4Ic6mux04QDLvkLEtkFbiFR01trCmnL+djJr4iA5
	 gbA+Mo5uiFvivjnZrrFXEHaa+p8DkPROSCSTJ1NdPTYhK4bEsj3vI7O6FkWbLi/Yk5
	 eQJ7MfyUqzYX7+o4lROqUDuxAg6GKHHHM/3XieWtbSz6hvHIRRrpdo7P9Yyp/MsUUB
	 uA+ZeD/s5bVre1Rh1uvdkX2Wwuw+SwGW5VUtJabbNtmpCW3+BerXfPoJpJpC0M7DId
	 zA/yh+BAR3o8g==
Date: Tue, 24 Jun 2025 15:43:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 08/11] exportfs: add FILEID_PIDFS
Message-ID: <20250624-zeitzeugen-gegraben-88ef5162e1fd@brauner>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-8-d02a04858fe3@kernel.org>
 <CAOQ4uxgA0FTB8jRC21uA6wC_5_VaFZB7O7CdF_EHA+HrBDS2DA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgA0FTB8jRC21uA6wC_5_VaFZB7O7CdF_EHA+HrBDS2DA@mail.gmail.com>

On Tue, Jun 24, 2025 at 03:15:18PM +0200, Amir Goldstein wrote:
> On Tue, Jun 24, 2025 at 10:29 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Introduce new pidfs file handle values.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  include/linux/exportfs.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > index 25c4a5afbd44..5bb757b51f5c 100644
> > --- a/include/linux/exportfs.h
> > +++ b/include/linux/exportfs.h
> > @@ -131,6 +131,11 @@ enum fid_type {
> >          * Filesystems must not use 0xff file ID.
> >          */
> >         FILEID_INVALID = 0xff,
> > +
> > +       /* Internal kernel fid types */
> > +
> > +       /* pidfs fid type */
> > +       FILEID_PIDFS = 0x100,
> >  };
> >
> 
> Jan,
> 
> I just noticed that we have a fh_type <= 0xff assumption
> built into fanotify:
> 
> /* Fixed size struct for file handle */
> struct fanotify_fh {
>         u8 type;
>         u8 len;
> 
> and we do not enforce it.
> there is only check of type range 1..0xffff
> in exportfs_encode_inode_fh()
> 
> We should probably do either:
> 
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -454,7 +454,7 @@ static int fanotify_encode_fh(struct fanotify_fh
> *fh, struct inode *inode,
>         dwords = fh_len >> 2;
>         type = exportfs_encode_fid(inode, buf, &dwords);
>         err = -EINVAL;
> -       if (type <= 0 || type == FILEID_INVALID || fh_len != dwords << 2)
> +       if (type <= 0 || type >= FILEID_INVALID || fh_len != dwords << 2)
>                 goto out_err;
> 
>         fh->type = type;
> 
> OR
> 
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -29,11 +29,10 @@ enum {
> 
>  /* Fixed size struct for file handle */
>  struct fanotify_fh {
> -       u8 type;
> +       u16 type;
>         u8 len;
>  #define FANOTIFY_FH_FLAG_EXT_BUF 1
>         u8 flags;
> -       u8 pad;
>  } __aligned(4);
> 
> 
> Christian,
> 
> Do you know if pidfs supports (or should support) fanotify with FAN_REPORT_FID?

I think it's at least supported by fanotify in that FAN_REPORT_FID and
FAN_REPORT_PIDFD aren't mutually exclusive options afaict. I don't know
if it's used though.

> If it does not need to be supported we can block it in fanotify_test_fid(),
> but if it does need fanotify support, we need to think about this.

Sure, block it.

> 
> Especially, if we want fanotify to report autonomous file handles.
> In that case, the design that adds the flag in the open_by_handle_at()
> syscall won't do.

Sorry, the design that adds the flag? You mean the FD_INVALID?
Why is that?

