Return-Path: <linux-fsdevel+bounces-60681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B706B500F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 17:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688BF1C615C9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 15:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBE8350D7B;
	Tue,  9 Sep 2025 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxOCgdeI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784C72BB17
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431360; cv=none; b=I8rH3JO6dg8Y8jrDIukk5619dhuWPaI1LRlWUtPrHnnSCFPdXCltHqP4dMy41XwtaEKq2X5Q2DsMQKFu+kJv/eiZgPrCx0bCt/8fqzmWj48423J+HLq3A5yn5q74IsHjBOY2MJ34XPgON3iOTZXeivQ+VFF2BlkcV35ZkrYpCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431360; c=relaxed/simple;
	bh=QEXhxovWYUHVgBkEl/gTdcNOIaqUcKQWivj1PPJZ8ak=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XvSffBYxjuZb4Q0FdVHU+I6X4cO57xIjEXSQVJU6AGATXs5p1cqhVBbV0Xncg2sBV/tMqEyzaLNIgYVDs1BDBsWdvPN/VMSnvKezWRBpioBQtDcihoh9PJDaw3ykWCzspdEaKp/Yoh3odtu+RBJkZcfkGQoVAoZqP18QF+O0Lww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FxOCgdeI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757431358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=z+VJfc5dyu/GsDQ2jOZqvhe7ZEO+uEqdgkyy6rtOglw=;
	b=FxOCgdeIDHe2cOeNNFAHI1IoHzw/aiW+7JFOq2gOletUVdYbS3qtbeYs+M0j2J34cgUjYF
	gyDecw/DYrZKtYu7cDJkrZlK3MezG/LkPofbohvymbYpc0Wyp9LkY2dleEKIwa0YE9AP/O
	jjIse3w24MhT6tQ8vfCDnPnLzfLyk+8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-zkPC_k5QNFiik-MYyQ2kKQ-1; Tue, 09 Sep 2025 11:22:37 -0400
X-MC-Unique: zkPC_k5QNFiik-MYyQ2kKQ-1
X-Mimecast-MFC-AGG-ID: zkPC_k5QNFiik-MYyQ2kKQ_1757431356
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e26569a11aso2870861f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 08:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431355; x=1758036155;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+VJfc5dyu/GsDQ2jOZqvhe7ZEO+uEqdgkyy6rtOglw=;
        b=XQP06Ne25aIw2ecOffhaUCN4yQdwFzUIv3a2a9azFRJxkb7Ll3PeK18m0Z8n4fJExp
         /VVxdHYQIKUxOuUNXG/66V/UTxkM7zVVnh2wpaoIPVQuteS4WfDd64i3zVMaDyJoII/Q
         D/1AzZ6AH/GUvS6JU8A2LMbxvTwXLOUlnakuxgwB4MsFOo6a/62NBD6t9/wHKxjUP0iX
         DYrem8M0+Xs2oUF0Ka0wTfPrVo9l8lVpbaJyaw4ON+sE2tagOGfOd0oCiLdgVutPKeav
         1bbJT8Oach8e2cMZHH4I3nwfbIwCBbF4IhWygYcPu9Ij3Kw2B9lTruWflCm9iv9fOs1O
         /nYg==
X-Forwarded-Encrypted: i=1; AJvYcCU4L6xthGS93/UE4zOIhYFaLwVcBHIp0LLcm5o1Hnaqi/8GaweTkVPny1ywzBb2sG9EMBsnESwLxDQQbajG@vger.kernel.org
X-Gm-Message-State: AOJu0YyTln6qinj3K1xRR0cuJTL+nWshlszGta+VQ1y8RH8FhRZOmDO1
	SoULdAxRj5L/L5rdXIXuV+NEuYZLS2hPS2c25utehsRgcKn5emJ1vTA2PiuZjzze4W8BKObguYP
	0d4DqZSKViul0X7YsO9cCFaIyPXh8mvHdQtfyGQSjzKCcEj/isWC/jwwCkqrb3DhRAwdLBAiTbt
	eB
X-Gm-Gg: ASbGncu4UFTy2vCY4sMaEZ7ei3wjpdt4urJk3uXRDh6EEUKP5SsZmzKppMLrw0QHkH8
	woIovcoAmUTYl8HHVtAo3o36nSiUsCdruvCSvpPIPZXtThxuufsiPnfyPnzolcxowbDsx75cRJI
	p9VmeYx50ULZ3qD1b/ttKDTp0mYdSSvq6QVSh7iiHChJIJy0iOxGQ5LdFPS8pdPsIPS52UsCHTq
	2gXQXGDTOFXZeKslBN1KwemQ4kUp1BAGtC8jV65X/Q41zpHRb9aAngooNBjGd0lqtm0SPwfOX2D
	C+Sgkwwxnpyj6mfDEU8zIG/oATgdy1/p
X-Received: by 2002:a05:6000:2dc4:b0:3c8:6b76:2ee9 with SMTP id ffacd0b85a97d-3e641a60df9mr9697503f8f.19.1757431355567;
        Tue, 09 Sep 2025 08:22:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe+xRxRQCkMmtxwSoqIUZRLPvVS5q6Y6mHlK4cZ6jPSpPnLLyRBNTHyPyXEqUm7yVvcmuEvA==
X-Received: by 2002:a05:6000:2dc4:b0:3c8:6b76:2ee9 with SMTP id ffacd0b85a97d-3e641a60df9mr9697489f8f.19.1757431355195;
        Tue, 09 Sep 2025 08:22:35 -0700 (PDT)
Received: from thinky ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de24ab648sm127055765e9.5.2025.09.09.08.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:22:34 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:22:34 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fstests@vger.kernel.org
Subject: Tests for file_getattr()/file_setattr() and xfsprogs update
Message-ID: <mqtzaalalgezpwfwmvrajiecz5y64mhs6h6pcghoq2hwkshcze@mxiscu7g7s32>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

This two patchsets are update to xfsprogs to utilize recently added
file_getattr() and file_setattr() syscalls.

The second patchset adds two tests to fstests, one generic one on
these syscals and second one is for XFS's original usecase for these
syscalls (projects quotas).

-- 
- Andrey


