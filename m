Return-Path: <linux-fsdevel+bounces-77550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF9sA2mKlWnqSAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 10:46:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEFC154D81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 10:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C725B301111D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 09:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0442F318EC8;
	Wed, 18 Feb 2026 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8Rz7/99";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMjHM2mZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ACA33A705
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771407969; cv=none; b=OI42PMzEGpfZIHiClgdxdZB1qQWeEYf9AKGA/RSEF5Rlo8Zlez4Kf/EsRMxX57AgINL3ANPcCLPpbSAjC/PGoGFP34IDaX9Xp4T3lZBXoXbmhtNe5K2Aki74HpajGc3aTEl6tNDBjOY3XC8GnVDp4+zuc1cHVSlBecKjz1sA1vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771407969; c=relaxed/simple;
	bh=+/zonLHVCNiYpF3F1mGEWfBegPViwa5HxidFiTwykE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1Yap991lFMwNyPEtJkzoeMXy0at104QM9SFqTO0Tqi20vwFR1/4rA8LFbpIchOVmHsKnajig+GzapNrgGWuBHKhZZl/ElQc5cBVSgsdTKcSbg4tQd+LV0tYt54V6iVy+wGTklY1INSGY89Lb3H0pVhWBRbMOrM1t7Uj/IN+Lms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b8Rz7/99; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EMjHM2mZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771407967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RyJBX+PISSbPZLtLewMjCIqsH1uiQW06yqBd1F+fu9Q=;
	b=b8Rz7/99/k8NSLyn6gIhNMqdyo48jGtwFqkNaAAxcAR/cKIeCI8nmnZ5eDcgTlqV1LNFph
	m48PmmGsgf+o1PK6ZKt5Gv8Ll69hJxQJHcB2Ns2tCAofH1cqqvVfLBAfhsnV2epfvTcnjX
	KT+vo42ySDM9yqe+dphKMTLTS4NXnwY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-1t74msZENmGto65lvB5L-g-1; Wed, 18 Feb 2026 04:46:06 -0500
X-MC-Unique: 1t74msZENmGto65lvB5L-g-1
X-Mimecast-MFC-AGG-ID: 1t74msZENmGto65lvB5L-g_1771407965
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-436267b01c4so4473527f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 01:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771407965; x=1772012765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RyJBX+PISSbPZLtLewMjCIqsH1uiQW06yqBd1F+fu9Q=;
        b=EMjHM2mZwQcFbUSpg6ErZ5H5HeecLNZBe+PM24XrTLhuWbO1Jo55TAXC+IRhRTo37r
         Xiod882IG8vbN4JcWlb5fhC7o2AWiNW6bTrMhWt66wsxMSGw7TDU/4l3VOJJUqVBvfg1
         bit5d1ler/sFnhu7uin6FTB6N0Oj8RkzRo7vo/2e9CGT/inzi3Ob/97qtb/HdPrIOQUo
         EpLSW7b4ruueE0eA7KFBrrUY9TVaaCkb97le+oxpJ5ko2qJV2cjKIJ2c1dFIzbYe4Aof
         VGsTUveRvBSYwBT3hgaqNZIh+qzovf/RvRFYfAH8kXq5wDxw8YEIBWvpmRQS2E9tpGkQ
         Gkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771407965; x=1772012765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyJBX+PISSbPZLtLewMjCIqsH1uiQW06yqBd1F+fu9Q=;
        b=wlaQ2qBaX3+yB4Z8eNMr0C/HSbz38cc0XMIdt1eDmkNnzAfxeNuvk0c1wQOtRd26XX
         oFvDmuQmoa2x3mZfVoLoSK9GT/W+YcF9R2YC3WXeDlf2JSZSmW81oTShAtEPveHgt5eG
         WBR3yCxRk8c4Y4cbo9Ieq0Gvf7hmCF1HxomIcttgJc9iBFLBEeszyOAqSe3VQ/byR2CV
         YbkzSBxPy6kihDjK1Z5yOB0Utf5molVRyWwry3BLLg8G0EW2BrMSZXJRFqOuat+/64vc
         k96tm5o0c3S/vukbnYnUSph9liJPFb57UdmFz4wUMb8ISkm3ueTSTmI/+8XF8UQ4w1iO
         XU7g==
X-Forwarded-Encrypted: i=1; AJvYcCXDUWaD172kBfq4pF727+UNEzqUp6jvJMBrKauXW0yI4OdsE5rY6JcimD2JPtFwWFXjWYXw5zbK5QnceEfJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzLhqTS0FTDSRCNhvCxEfA0f/ELYkladIOqD0eiZ74yKYZTTBeI
	eqAAUSmfnI1agANxqDpLjvywaoA7p6oiYgaD43kH+cFWzCb443nJ+d133FXNj/paBKP+5UXH+OA
	s2xOFXDDix7k9ERk4gza6tB5neKddEf3XwhQ+SCqtBy3G1UZotmdFAkDYB+vjlM7F3XoQFZlcJA
	==
X-Gm-Gg: AZuq6aKZd1EVRVMufozXFJXmDLXqK/LUTGSH3kYYabhqkhNnK8bqF3QnfCo96m6MHx8
	wdDgacuM8ZLOh7paYZRnDwzekOoMMDtLQs+twVChjctzshX5UOMy+MLL68B4OZ7xt7jjMVH2d2J
	2Ma8Dis+mmnzSyPTNKkKKQegKQ6ylYMe87eegXjzoEqK5Chq6PtLgbdUI8a3KIvrgjfjmbmOaaP
	Y5JGa2I3EM70NeeaWRRSHf6e6dQP9dgaAZWYjzvIW+GaoBwxPwL0QFDiSuxl4c03L90xOvXxBGe
	tFK6ClsUPMlUsHh+gD5H4atHlHr+vUSXACbRWRpEEOrQekDtiFGzn/kcsbYNKZLf9qBn0p5ZNo9
	SJXFOsnIadmQ=
X-Received: by 2002:a05:600c:4f92:b0:482:eec4:76d with SMTP id 5b1f17b1804b1-48398b5e0d0mr23667655e9.17.1771407964651;
        Wed, 18 Feb 2026 01:46:04 -0800 (PST)
X-Received: by 2002:a05:600c:4f92:b0:482:eec4:76d with SMTP id 5b1f17b1804b1-48398b5e0d0mr23667385e9.17.1771407964108;
        Wed, 18 Feb 2026 01:46:04 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48387ab1974sm196913305e9.3.2026.02.18.01.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 01:46:03 -0800 (PST)
Date: Wed, 18 Feb 2026 10:46:02 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, 
	djwong@kernel.org
Subject: Re: [PATCH v3 23/35] xfs: add helper to check that inode data need
 fsverity verification
Message-ID: <7c2kegonzbfrdv3thcrorgadyuejyknb3uipxlbxkpa4gfgu3t@zpowelexa6zu>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-24-aalbersh@kernel.org>
 <20260218063827.GA8768@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218063827.GA8768@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77550-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FEFC154D81
X-Rspamd-Action: no action

On 2026-02-18 07:38:27, Christoph Hellwig wrote:
> On Wed, Feb 18, 2026 at 12:19:23AM +0100, Andrey Albershteyn wrote:
> > +	       (offset < fsverity_metadata_offset(inode));
> 
> No need for the braces.
> 
> > +}
> > +
> > diff --git a/fs/xfs/xfs_fsverity.h b/fs/xfs/xfs_fsverity.h
> > new file mode 100644
> > index 000000000000..5fc55f42b317
> > --- /dev/null
> > +++ b/fs/xfs/xfs_fsverity.h
> > @@ -0,0 +1,22 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2026 Red Hat, Inc.
> > + */
> > +#ifndef __XFS_FSVERITY_H__
> > +#define __XFS_FSVERITY_H__
> > +
> > +#include "xfs.h"
> > +
> > +#ifdef CONFIG_FS_VERITY
> > +bool xfs_fsverity_sealed_data(const struct xfs_inode *ip,
> > +		loff_t offset);
> > +#else
> > +static inline loff_t xfs_fsverity_offset_to_disk(struct xfs_inode *ip,
> > +						 loff_t pos)
> > +{
> > +	WARN_ON_ONCE(1);
> > +	return ULLONG_MAX;
> > +}
> > +#endif	/* CONFIG_FS_VERITY */
> 
> It looks like this got messed up a bit when splitting the patches and
> you want an xfs_fsverity_sealed_data stub here?

oh, right, haven't noticed that, will fix this

> 
> Also I'm not sure introducing the "sealed" terminology just for this
> function make much sense.  Just say xfs_is_fsverity_data maybe?
> 

sure, xfs_fsverity_is_data/_is_file_data maybe? to keep consistent
xfs_fsverity_ prefix

-- 
- Andrey


