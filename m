Return-Path: <linux-fsdevel+bounces-16829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D382A8A3635
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 21:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57563B217EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 19:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF62314F9E8;
	Fri, 12 Apr 2024 19:11:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CF014AD37
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712949112; cv=none; b=J6G+fDNUOFfeNgwaYcQSG5VpZ0gzTCVk/c8686ynstvhdxcdXfFSzUXRIPCxRD75AKsPi/iK6l4TsFUteNvCyZXkqrlI005ZwV4H1/7RREUTCeU1EkREhe96M0/IycX4iFJeZEwMre0rBRNlH3NX2ATGDLrbnV1NM7lz2hpmsv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712949112; c=relaxed/simple;
	bh=H5+Z366wKFm0NBKhaM7r10o+w2go1jg4s+i8Bg/nfW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovW7mjFFP54tyOTaQJGK8LRkRioB52xGP/m78e4PYR3n5QToULdCOUe6huLqQPRXH7DV84usFSpVmWU103mWb3ewvufoiCfdWw5vKWpbxLYxASOODzZ3D1wHSqxY85mH/B4sNyclVMFYcXtCMB1a8X0P+VVd9PCvIb68SDHbkk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78ecd752a7cso45674785a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 12:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712949110; x=1713553910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5+Z366wKFm0NBKhaM7r10o+w2go1jg4s+i8Bg/nfW8=;
        b=NKhAyhPttfr/fDSX8xn8VQ2VV2WdxfXMKnvQ8ODqc7eigOSr1KR6tHF2vopz6n2yL+
         6HZY0twty1whtQAgZdoAgwKFPGACO7TLF1UhiuGy/2XwN9r8HGKDm53Nx0ytqYbpMI04
         +zpeB2Y+A6dw+F4U0X/fyIhnSKySjDSifrD6SqwEqgfRxHG0jM8PN8/wKAnDwSQV+2AY
         tHLynGB6iGtspf9GffbBl6o8YWoFBdXY/aGT+kfUYWcB2Y+Dt/9HAP3PPxvWlzyF7L+P
         E2AeB2DarFaRLKPgovBxntfrBXwXJ7BkzfRKPzvJRVv/o8CO5YjVl04Q2p+/aL+tgcdf
         TlyA==
X-Forwarded-Encrypted: i=1; AJvYcCWUCMyxpMBVNFhcBmmQKniv+emsdIgDY+VZIzPk2d7onzSa81aTor5XB5nAULnJ7v5uM+m759h+Swr+56/ltOZy+U6w1lukrfpMDbFn6w==
X-Gm-Message-State: AOJu0YywDgHWahXo/dg45aO7AKV2cECIzIpMS5zm7t7rSHfyQ+x/8+TN
	FXVHUB4PHF4XCCU+fQs/PkMAMOVx5FxFOKYZJpfsF/cYq31YCTjV2dJBlrf+KFA=
X-Google-Smtp-Source: AGHT+IGeLin3taHlFSSUyXln284AJet9b+/a2Qcn+Ghx2lQ0DWoWRHuSus3v3xl2tUKwhypqZgUl2g==
X-Received: by 2002:ad4:55d3:0:b0:69b:229e:91f6 with SMTP id bt19-20020ad455d3000000b0069b229e91f6mr3530788qvb.52.1712949110132;
        Fri, 12 Apr 2024 12:11:50 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id ph3-20020a0562144a4300b0069942e76d99sm2662096qvb.48.2024.04.12.12.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 12:11:49 -0700 (PDT)
Date: Fri, 12 Apr 2024 15:11:48 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: iomap: convert iomap_writepages to writeack_iter
Message-ID: <ZhmHdEhnmbxJPKIX@redhat.com>
References: <20240412061614.1511629-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412061614.1511629-1-hch@lst.de>

FYI, noticed a typo in the subject: s/writeack_iter/writeback_iter/

