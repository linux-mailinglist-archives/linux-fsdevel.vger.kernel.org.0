Return-Path: <linux-fsdevel+bounces-23435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 873C092C35A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 20:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123D31F23F8C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 18:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7093518005D;
	Tue,  9 Jul 2024 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="WwSf4ZW7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E0917B038
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720550247; cv=none; b=WJRAu0ZqRfx7RQbOfgJ9iUuJwholDacZJR9p9pTdd/mNUyhW4p03QOsq96gx4QRhCMyQydtP/tM9kRpe88+JMjUYiZfEyKGNZLz04MoAu7SiYGdLVBABWX+61/IpwHwMzDneZTtNWQiYelxkHL3ZDarVm9aE4CKXorcr5jNdFY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720550247; c=relaxed/simple;
	bh=76e0AThX4nHGzV/JWb+MjOlSQFPOtEp58fvFpMLysqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7965bxDggi/cXQ80CvyZKrOTF5sSmAvpnOQ+rBbSzFwcmy6MGAPfAHLSzIWo3tLmCB2uTMxFrWDZWK1FAvWrKtewF1FcxkCC7hLYJjKdA8Chji7SKG5/9wi0k6dNuWttfqTgYWVlVGscQUVAAegZQ2GOAGQ2uvaI+YjF5SRf0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=WwSf4ZW7; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-446883be273so30328751cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jul 2024 11:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720550245; x=1721155045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s95nLszVKEzyqhjXX5qfk5zJ49ZggB6hFCKO1Fc1bi4=;
        b=WwSf4ZW7NqEFmMMxTt6eaeOmHsekFbaiWa/ur36/q2JqumXKNpIzHaHg7Sq5HLE2Rw
         kRk01EMnFZ6Rbsz3DuAAZbW+cR30brCpgLTdt/ppnbf8CU9jlaMfXr4h7+/sAiNhc9JE
         A+KZbimDP5pakKNed4xmSuaCG4t5D6zxTAZBDcAU99bWPF1nmUPwpoQu4Op4ZvmwthP6
         1bAHYuk2pnXuL3SFXgXp4xpLYL1vPRBze6cIXO36/lMMc1nBdax8fVz5sboAAQpvdpzA
         QF2M3DRodfz1hAYntoxP+mE2wDDTv8oIiGZVUIDJ+FgqIwSJVJZLE/ZzCp7dEk+vozvz
         FLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720550245; x=1721155045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s95nLszVKEzyqhjXX5qfk5zJ49ZggB6hFCKO1Fc1bi4=;
        b=dRnbmnxB50Tl1z7KRQhI5jZf19h+D8HGLsWiZGTCOcMWbNDrA9gjZrKT5PZ+dDfvTD
         dHcaeV02kRAnzY0L6C5GNMf6HpRWnEkQqL1Ix5vLFnH5fcZaiaA3+d+uXVPYzya5coFK
         tGhtjaSN/Bk8qR2zsgMrQQW4nVpeQPQpwAfRzXMxC2EJi4FMf8xZCm6NXDTnAaqckgPM
         FWf5p0MB7VYzUFSuvAcp27D6uWfnBdfA/1yGDZfCZbI+89CGrB2jos4VjiE23ANqDis0
         mWt7sHSBigp/nNQ1El5R34Q6/yTtf5sWa4A4q1oIm5wYLWRxVD3ncuC0Bq576wgfPtFg
         zWLw==
X-Forwarded-Encrypted: i=1; AJvYcCWMZZ+ioqJA0S+VF+/DwSMQBys66dytxEVQjWLhienGtv62Flez6ybQq+CfOVpNtOS+i6TpMbjAGtIy0p/laV0tiRyeqIDQnAOhQdg0aw==
X-Gm-Message-State: AOJu0Yz5BUzZDIxykFJtyAA1D1114UdHUjKUti4jYU+k+h0ZmTw0KXUx
	o/gGPbBGPgLPBlEko4QhadcQ+I49xN/DgBLX1HEpm3B//PStcQx8sIdflcAyzxZSOjFOyjP7TQU
	D
X-Google-Smtp-Source: AGHT+IHWsPMvyZWjYk07SvN/4IKNa9WNEWneKJhfnbCiVkYKx//YsIGDnrZQ8dnMmnwJmr+Ng2XOqg==
X-Received: by 2002:a05:6214:29ed:b0:6b2:d69d:a2d7 with SMTP id 6a1803df08f44-6b61bca16c2mr38187486d6.19.1720550245211;
        Tue, 09 Jul 2024 11:37:25 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9bf6c53sm12822721cf.95.2024.07.09.11.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 11:37:24 -0700 (PDT)
Date: Tue, 9 Jul 2024 14:37:24 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com,
	kernel-team@fb.com
Subject: Re: [PATCH v5 1/2] statmount.2: New page describing the statmount
 syscall
Message-ID: <20240709183724.GB1045536@perftesting>
References: <cover.1720545710.git.josef@toxicpanda.com>
 <009928cf579a38577f8d6cc644c115556f9a3576.1720545710.git.josef@toxicpanda.com>
 <fx5grrvxxxjx3cu5dej5uit6qsaownahwc644ku52vxcuzhhn3@dqjkofvlsopn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fx5grrvxxxjx3cu5dej5uit6qsaownahwc644ku52vxcuzhhn3@dqjkofvlsopn>

On Tue, Jul 09, 2024 at 07:48:54PM +0200, Alejandro Colomar wrote:
> Hi Josef,
> 
> On Tue, Jul 09, 2024 at 01:25:42PM GMT, Josef Bacik wrote:
> > Add some documentation on the new statmount syscall.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> It's looking good already.  Please see some comments below.
> 
> Have a lovely day!
> Alex
> 
> > ---
> >  man/man2/statmount.2 | 280 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 280 insertions(+)
> >  create mode 100644 man/man2/statmount.2
> > 
> > diff --git a/man/man2/statmount.2 b/man/man2/statmount.2
> > new file mode 100644
> > index 000000000..c437ea685
> > --- /dev/null
> > +++ b/man/man2/statmount.2
> > @@ -0,0 +1,280 @@
> > +'\" t
> > +.\" Copyright (c) 2024 Josef Bacik <josef@toxicpanda.com>
> > +.\"
> > +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> > +.\"
> > +.TH statmount 2 (date) "Linux man-pages (unreleased)"
> > +.SH NAME
> > +statmount \- get a mount status
> > +.SH LIBRARY
> > +Standard C library
> > +.RI ( libc ", " \-lc )
> > +.SH SYNOPSIS
> > +.nf
> > +.BR "#include <linux/mount.h>" "  /* Definition of STATMOUNT_* constants */"
> > +.B #include <unistd.h>
> > +.P
> > +.BI "int syscall(SYS_statmount, struct mnt_id_req * " req ,
> > +.BI "            struct statmount * " smbuf ", size_t " bufsize ,
> > +.BI "            unsigned long " flags );
> > +.P
> > +.B #include <linux/mount.h>
> > +.P
> > +.B struct mnt_id_req {
> > +.BR "    __u32 size;" "    /* sizeof(struct mnt_id_req) */"
> > +.BR "    __u64 mnt_id;" "  /* The mnt_id being queried */"
> > +.BR "    __u64 param;" "   /* An ORed combination of the STATMOUNT_ constants */"
> > +.B };
> > +.P
> > +.B struct statmount {
> > +.B "    __u32 size;"
> > +.B "    __u64 mask;"
> > +.B "    __u32 sb_dev_major;"
> > +.B "    __u32 sb_dev_minor;"
> > +.B "    __u64 sb_magic;"
> > +.B "    __u32 sb_flags;"
> > +.B "    __u32 fs_type;"
> > +.B "    __u64 mnt_id;"
> > +.B "    __u64 mnt_parent_id;"
> > +.B "    __u32 mnt_id_old;"
> > +.B "    __u32 mnt_parent_id_old;"
> > +.B "    __u64 mnt_attr;"
> > +.B "    __u64 mnt_propagation;"
> > +.B "    __u64 mnt_peer_group;"
> > +.B "    __u64 mnt_master;"
> > +.B "    __u64 propagate_from;"
> > +.B "    __u32 mnt_root;"
> > +.B "    __u32 mnt_point;"
> > +.B "    char  str[];"
> > +.B };
> > +.fi
> > +.P
> > +.IR Note :
> > +glibc provides no wrapper for
> > +.BR statmount (),
> > +necessitating the use of
> > +.BR syscall (2).
> > +.SH DESCRIPTION
> > +To access a mount's status,
> > +the caller must have CAP_SYS_ADMIN in the user namespace.
> > +.P
> > +This function returns information about a mount,
> > +storing it in the buffer pointed to by
> > +.IR smbuf .
> > +The returned buffer is a
> > +.I struct statmount
> > +which is of size
> > +.I bufsize
> > +with the fields filled in as described below.
> > +.P
> > +(Note that reserved space and padding is omitted.)
> > +.SS The mnt_id_req structure
> > +.I req.size
> > +is used by the kernel to determine which
> > +.I struct\~mnt_id_req
> > +is being passed in;
> > +it should always be set to
> > +.IR sizeof(struct\~mnt_id_req) .
> > +.P
> > +.I req.mnt_id
> > +can be obtained from either
> > +.BR statx (2)
> > +using
> > +.B STATX_MNT_ID_UNIQUE
> > +or from
> > +.BR listmount (2)
> > +and is used as the identifier to query the status of the desired mount point.
> > +.P
> > +.I req.param
> > +is used to tell the kernel which fields the caller is interested in.
> > +It is an ORed combination of the following constants
> > +.P
> > +.in +4n
> > +.TS
> > +lB l.
> > +STATMOUNT_SB_BASIC	/* Want/got sb_* */
> > +STATMOUNT_MNT_BASIC	/* Want/got mnt_* */
> > +STATMOUNT_PROPAGATE_FROM	/* Want/got propagate_from */
> > +STATMOUNT_MNT_ROOT	/* Want/got mnt_root  */
> > +STATMOUNT_MNT_POINT	/* Want/got mnt_point */
> > +STATMOUNT_FS_TYPE	/* Want/got fs_type */
> > +.TE
> > +.in
> > +.P
> > +In general,
> > +the kernel does
> > +.I not
> > +reject values in
> > +.I req.param
> > +other than the above.
> > +(For an exception,
> > +see
> > +.B EINVAL
> > +in errors.)
> > +Instead,
> > +it simply informs the caller which values are supported
> > +by this kernel and filesystem via the
> > +.I statmount.mask
> > +field.
> > +Therefore,
> > +.I "do not"
> > +simply set
> > +.I req.param
> > +to
> > +.B UINT_MAX
> > +(all bits set),
> > +as one or more bits may,
> > +in the future,
> > +be used to specify an extension to the buffer.
> > +.SS The returned information
> > +The status information for the target mount is returned in the
> > +.I statmount
> > +structure pointed to by
> > +.IR smbuf .
> > +.P
> > +The fields in the
> > +.I statmount
> > +structure are:
> > +.TP
> > +.I smbuf.size
> > +The size of the returned
> > +.I smbuf
> > +structure,
> > +including any of the strings fields that were filled.
> > +.TP
> > +.I smbuf.mask
> > +The ORed combination of
> > +.BI STATMOUNT_ *
> > +flags indicating which fields were filled in and thus valid.
> > +The kernel may return fields that weren't requested,
> > +and may fail to return fields that were requested,
> > +depending on what the backing file system and kernel supports.
> > +In either case,
> > +.I req.param
> > +will not be equal to
> > +.IR mask .
> > +.TP
> > +.I smbuf.sb_dev_major
> > +.TQ
> > +.I smbuf.sb_dev_minor
> > +The device that is mounted at this mount point.
> > +.TP
> > +.I smbuf.sb_magic
> > +The file system specific super block magic.
> > +.TP
> > +.I smbuf.sb_flags
> > +The flags that are set on the super block,
> > +an ORed combination of
> > +.BR SB_RDONLY ,
> > +.BR SB_SYNCHRONOUS ,
> > +.BR SB_DIRSYNC ,
> > +.BR SB_LAZYTIME .
> > +.TP
> > +.I smbuf.fs_type
> > +The offset to the location in the
> > +.I smbuf.str
> > +buffer that contains the string representation of the mounted file system.
> > +It is a null-terminated string.
> > +.TP
> > +.I smbuf.mnt_id
> > +The unique mount ID of the mount.
> > +.TP
> > +.I smbuf.mnt_parent_id
> > +The unique mount ID of the parent mount point of this mount.
> > +If this is the root mount point then
> > +.IR smbuf.mnt_id\~==\~smbuf.parent_mount_id .
> > +.TP
> > +.I smbuf.mnt_id_old
> > +This corresponds to the mount ID that is exported by
> > +.IR /proc/ pid /mountinfo .
> > +.TP
> > +.I smbuf.mnt_parent_id_old
> > +This corresponds to the parent mount ID that is exported by
> > +.IR /proc/ pid /mountinfo .
> > +.TP
> > +.I smbuf.mnt_attr
> > +The
> > +.BI MOUNT_ATTR_ *
> > +flags set on this mount point.
> > +.TP
> > +.I smbuf.mnt_propagation
> > +The mount propagation flags,
> > +which can be one of
> > +.BR MS_SHARED ,
> > +.BR MS_SLAVE ,
> > +.BR MS_PRIVATE ,
> > +.BR MS_UNBINDABLE .
> > +.TP
> > +.I smbuf.mnt_peer_group
> > +The ID of the shared peer group.
> > +.TP
> > +.I smbuf.mnt_master
> > +The mount point receives its propagation from this mount ID.
> > +.TP
> > +.I smbuf.propagate_from
> > +The ID from the namespace we propagated from.
> > +.TP
> > +.I smbuf.mnt_root
> > +The offset to the location in the
> > +.I smbuf.str
> > +buffer that contains the string representation of the mount
> > +relative to the root of the file system.
> > +It is a NULL terminated string.
> 
> s/NULL terminated/null-terminated/
> 
> NULL is the null pointer constant.
> NUL is the ASCII name for the null byte.
> We say null-terminated, because someone (probably Michael Kerrisk)
> thought NULL and NUL were confusing.  :)
> 

This is probably worth adding to 'make check' to save you time from telling me
to do that when I screw it up again in the future.  Thanks,

Josef

