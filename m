Return-Path: <linux-fsdevel+bounces-77992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKygL3eanGmKJgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 19:20:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 619B417B6F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 19:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBBF93049165
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 18:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A0E33CEA5;
	Mon, 23 Feb 2026 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkztQmXW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMELSw5N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6986133D6C9
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771870771; cv=none; b=HQGCftOuD//soqwrNAk75bLO6T5WJ0DytNhl4HU1ts61YCjLvk0VlM7PuiNYhVstIdxwgVclNlsdHyfmcHXfr3mr5hkskytCnZNXzUhnxUe3VpneEiGGJVPqojUNwzfuUZ+OVELqmpakVxmloRLGE0J7OYwGOYjFZZAEvh1Rc7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771870771; c=relaxed/simple;
	bh=tYg6lKXCrXqkSRjroh8xnR35YcUacejrcTuL0nB1Jg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrOnOZe3lJbVA68e/31ANCUuoLsMJsypO9IEKnJzYmL/RHXaujrN6s7BhRtcKt+KWqNCP+bVbfGTGPSUy6Voi6cNTFi+L92gr0DZEvF/sGU9tiftS8bKF5XHc4pe//uUhtKexp5XJh7SGDDi3L9usS01IPupljv3Rhyt/pn1wmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dkztQmXW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CMELSw5N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771870764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ifqmgc0Bd/dYXqGP8nteQfhBSpKJvq3ZUBjnYwveQk=;
	b=dkztQmXWUtEPxI9sTN9Nibc8hOS+uxHsEAHMNOy9NRBTpJlqd8W8i9rw+YSAUmbzV+GEnI
	eQDaDFKmYoKmPIiRTtJZpteq7nWY56NOpkvM0wkanJXBkSYd7QQY8XHzam2JdiRXgYg/cA
	FJFlNHvKvWoVYyYbr1d7W9CZNSpOl3k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-qitrSl6QPK6OwVV-NoyTTA-1; Mon, 23 Feb 2026 13:19:21 -0500
X-MC-Unique: qitrSl6QPK6OwVV-NoyTTA-1
X-Mimecast-MFC-AGG-ID: qitrSl6QPK6OwVV-NoyTTA_1771870760
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-435ab907109so3725956f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 10:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771870760; x=1772475560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ifqmgc0Bd/dYXqGP8nteQfhBSpKJvq3ZUBjnYwveQk=;
        b=CMELSw5NQJZgvFoLaBpbPb1/kcl8z9hiFK1axxzRKIYj/cKHBd8TcFAQRBDQlAV89K
         /TbZcIVev1E0JhbF5gforNUnGeN42pKxtXql1aOy1A4Src5po27AMxtjZmUExep7IFk+
         ewvc/ruAWYsgl+QYimErrT7Nlp0m8V9ieOsZzA40G1e1RvmVrNFvHDH5AvjxkZsKbbPQ
         7o6GG8G2qnRs/cdwCmrVg0AnOCXY4sc1gFVLIO6vRMZ+8qGZQE469byx6HdLIPIIUEpc
         Afjld7IfKjFwzF7g3BYhgtVp0U8tLHgQ9Macj6YxYIyN9ZLIWL/Oj/vQX2qIZOWeC+al
         QkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771870760; x=1772475560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ifqmgc0Bd/dYXqGP8nteQfhBSpKJvq3ZUBjnYwveQk=;
        b=tgMmO5pNJe8l7syk9UBdZK0MQjfDK9vFdDWAK2iuUgT6K2XVmJZ5zVA6BHI1auKXoc
         VYgwERRjf1outHI7Zl1U1hSvqBOtiodn41kFq5utbBKApYVaYcEFu/Z8Wm/fN3f5Fae5
         OETqWpOsrbhvVil+t2VTixO7GuBBHFGpu2k0gJzgpCrkZUVUjpKbjCHemGyShB/X9LXK
         cZYnjZOZhANq7i4F4mPfAogf+3wCVSG4rlkmiKRwScdilvB2kCS1K77N/E9Yv8XMvxOi
         RN+oxaqNOMkU/O1vmrv2BpqQUBAF3xsSxpcjQX820K1wA8Bzm9JRJ7O0qkgMubLKTjJi
         h8ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVBAcV7CR9L0hdqLD8SgevZ2WE/IuQZc8J967CB69K03R12cgydt5rMKOCJjtrspo5obJGjGZIp8yz23D0A@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6/f8qgm2YFobSYtnyVo25YbtxESG0QgFr108yhyS/Br0jV3at
	s5G1VIL/iZ9jr5dkaPZMfP3fwmpnlmgWMZQmtw7SAUV0mCp6x8e3o12h4I1LFUvvF1cnWOuQ57j
	LRhaTGIbMPFYOtaKGnzbFuY8MgBbd2TYytaovJ4N6X+FGIipa1bB32bJ6uR/qAUMxQg==
X-Gm-Gg: ATEYQzxTdVVJ9kg2uVg2A4MHNktq9wpwYV9SLjXedY+UmD5doGO2Q9hzghKy571gX2a
	v8sU380vd1NcSiQp+bGPvpJHWcWcP3ryxQ38Qa8Yp+Mbo3UajdOQtREGp+qZ5B6Co8gOoEzyKPN
	ZG4OkOAobe2F5+DcFfAPRkdGZ6tt1zZz2ZVjn0q/WLG494tWszt6MuJyTtzCbMQdCKvuzEvWU7+
	kfrwg9I6fKK/TWY1F+7oqUcznJVGIGyMlXW3juun3Nx5Iqqm08A5qYR4f2UP52u7gkvdWUHnxxN
	j7e4bO7GKiDmhKucRFmz6JaMRRUb5XKSS4mNRw87Jb2r80aP5hILJQsvLTH9gDCCo31315wPDO5
	P6J3W85oIO1A=
X-Received: by 2002:a05:6000:2301:b0:435:a501:359 with SMTP id ffacd0b85a97d-4396f18a666mr17997605f8f.41.1771870760132;
        Mon, 23 Feb 2026 10:19:20 -0800 (PST)
X-Received: by 2002:a05:6000:2301:b0:435:a501:359 with SMTP id ffacd0b85a97d-4396f18a666mr17997554f8f.41.1771870759664;
        Mon, 23 Feb 2026 10:19:19 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c08b9csm23518931f8f.16.2026.02.23.10.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 10:19:19 -0800 (PST)
Date: Mon, 23 Feb 2026 19:19:18 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de
Subject: Re: [PATCH v3 33/35] xfs: introduce health state for corrupted
 fsverity metadata
Message-ID: <zv5rshpef3fti4ldwhfcaekmjjzcwtxr3fgtabwyufkhcn4gvw@uk4ojtvmxquc>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-34-aalbersh@kernel.org>
 <20260219173427.GL6490@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219173427.GL6490@frogsfrogsfrogs>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77992-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 619B417B6F2
X-Rspamd-Action: no action

On 2026-02-19 09:34:27, Darrick J. Wong wrote:
> On Wed, Feb 18, 2026 at 12:19:33AM +0100, Andrey Albershteyn wrote:
> > Report corrupted fsverity descriptor through health system.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> 
> Looks good to me, though I'll have to revisit this with a sharper eye
> for what happens if/when you rebase to use fserror_*.
> 
> IIRC inconsistencies between the merkle tree and the file data are
> reported as -EIO, right?

iomap reports -EIO on the file data read, and fsverity_verify_bio()
will report block size failure with fserror_report_data_lost().

> And at that point we have the file range
> information, so we could actually use fserror_report_data_lost.
> 
> I forget, what do we do for inconsistencies between an internal node of
> the merkle tree and the next level down?  That sounds like something
> that should set XFS_SICK_INO_FSVERITY, right?

It's done by fsverity itself in verify_data_block() and will be
reported with fserror_report_data_lost().

> For this bit involving just the fsverity descriptor,
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Thanks!

> 
> --D
> 
> > ---
> >  fs/xfs/libxfs/xfs_fs.h     |  1 +
> >  fs/xfs/libxfs/xfs_health.h |  4 +++-
> >  fs/xfs/xfs_fsverity.c      | 13 ++++++++++---
> >  fs/xfs/xfs_health.c        |  1 +
> >  4 files changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
> > index 36a87276f0b7..d8be7fe93382 100644
> > --- a/fs/xfs/libxfs/xfs_fs.h
> > +++ b/fs/xfs/libxfs/xfs_fs.h
> > @@ -423,6 +423,7 @@ struct xfs_bulkstat {
> >  #define XFS_BS_SICK_PARENT	(1 << 7)  /* parent pointers */
> >  #define XFS_BS_SICK_DIRTREE	(1 << 8)  /* directory tree structure */
> >  #define XFS_BS_SICK_DATA	(1 << 9)  /* file data */
> > +#define XFS_BS_SICK_FSVERITY	(1 << 10) /* fsverity metadata */
> >  
> >  /*
> >   * Project quota id helpers (previously projid was 16bit only
> > diff --git a/fs/xfs/libxfs/xfs_health.h b/fs/xfs/libxfs/xfs_health.h
> > index fa91916ad072..c534aacf3199 100644
> > --- a/fs/xfs/libxfs/xfs_health.h
> > +++ b/fs/xfs/libxfs/xfs_health.h
> > @@ -105,6 +105,7 @@ struct xfs_rtgroup;
> >  #define XFS_SICK_INO_FORGET	(1 << 12)
> >  #define XFS_SICK_INO_DIRTREE	(1 << 13)  /* directory tree structure */
> >  #define XFS_SICK_INO_DATA	(1 << 14)  /* file data */
> > +#define XFS_SICK_INO_FSVERITY	(1 << 15)  /* fsverity metadata */
> >  
> >  /* Primary evidence of health problems in a given group. */
> >  #define XFS_SICK_FS_PRIMARY	(XFS_SICK_FS_COUNTERS | \
> > @@ -142,7 +143,8 @@ struct xfs_rtgroup;
> >  				 XFS_SICK_INO_SYMLINK | \
> >  				 XFS_SICK_INO_PARENT | \
> >  				 XFS_SICK_INO_DIRTREE | \
> > -				 XFS_SICK_INO_DATA)
> > +				 XFS_SICK_INO_DATA | \
> > +				 XFS_SICK_INO_FSVERITY)
> >  
> >  #define XFS_SICK_INO_ZAPPED	(XFS_SICK_INO_BMBTD_ZAPPED | \
> >  				 XFS_SICK_INO_BMBTA_ZAPPED | \
> > diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
> > index 5a2874236c3c..d89512d59328 100644
> > --- a/fs/xfs/xfs_fsverity.c
> > +++ b/fs/xfs/xfs_fsverity.c
> > @@ -197,16 +197,23 @@ xfs_fsverity_get_descriptor(
> >  		return error;
> >  
> >  	desc_size = be32_to_cpu(d_desc_size);
> > -	if (XFS_IS_CORRUPT(mp, desc_size > FS_VERITY_MAX_DESCRIPTOR_SIZE))
> > +	if (XFS_IS_CORRUPT(mp, desc_size > FS_VERITY_MAX_DESCRIPTOR_SIZE)) {
> > +		xfs_inode_mark_sick(XFS_I(inode), XFS_SICK_INO_FSVERITY);
> >  		return -ERANGE;
> > -	if (XFS_IS_CORRUPT(mp, desc_size > desc_size_pos))
> > +	}
> > +
> > +	if (XFS_IS_CORRUPT(mp, desc_size > desc_size_pos)) {
> > +		xfs_inode_mark_sick(XFS_I(inode), XFS_SICK_INO_FSVERITY);
> >  		return -ERANGE;
> > +	}
> >  
> >  	if (!buf_size)
> >  		return desc_size;
> >  
> > -	if (XFS_IS_CORRUPT(mp, desc_size > buf_size))
> > +	if (XFS_IS_CORRUPT(mp, desc_size > buf_size)) {
> > +		xfs_inode_mark_sick(XFS_I(inode), XFS_SICK_INO_FSVERITY);
> >  		return -ERANGE;
> > +	}
> >  
> >  	desc_pos = round_down(desc_size_pos - desc_size, blocksize);
> >  	error = xfs_fsverity_read(inode, buf, desc_size, desc_pos);
> > diff --git a/fs/xfs/xfs_health.c b/fs/xfs/xfs_health.c
> > index b851651c02b2..e52ee02f7d7c 100644
> > --- a/fs/xfs/xfs_health.c
> > +++ b/fs/xfs/xfs_health.c
> > @@ -488,6 +488,7 @@ static const struct ioctl_sick_map ino_map[] = {
> >  	{ XFS_SICK_INO_SYMLINK_ZAPPED,	XFS_BS_SICK_SYMLINK },
> >  	{ XFS_SICK_INO_DIRTREE,	XFS_BS_SICK_DIRTREE },
> >  	{ XFS_SICK_INO_DATA,	XFS_BS_SICK_DATA },
> > +	{ XFS_SICK_INO_FSVERITY,	XFS_BS_SICK_FSVERITY },
> >  };
> >  
> >  /* Fill out bulkstat health info. */
> > -- 
> > 2.51.2
> > 
> > 
> 

-- 
- Andrey


