Return-Path: <linux-fsdevel+bounces-39115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 627E2A0FFF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 05:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1CD168D32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 04:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAE324022A;
	Tue, 14 Jan 2025 04:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="OYXMMdQ5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2775588E
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 04:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736829809; cv=none; b=rhMH7m9jXg5hs21V6bhPXqZcrTRfp4DDaIoERYMlRHgavubgSX4lfSOieYTL2qKdeuWnT1DWZzSC2DfiKWjCvhiEsrTajHCaf7Zrg/GHxM1Lwf1BxcoVsJGpc8AOSDFr+5uw+lmkKy7fmVVSLkdZtdfNO5AzfGrWFIw15hDFy/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736829809; c=relaxed/simple;
	bh=nO5AagkuvG0CHgpgTF/sFlqC52MFQQuVw34NJHOjQUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPbdf+Xltp11hrIfRjJ4BJPPQ13aekIg32KzfJ0FymUYuNRQmbxAS0mjd6mue4iz6MQoZb6EiKqX6eEwhU1p/ex+WVtEu1SDHB+hcTyFDJasr03/tKdXJJQxjyX06xrzk/AzXN4D+ITqgpOu9t7C/3AJM40vwTx8oYgYN/ngr6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=OYXMMdQ5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2163b0c09afso92003325ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 20:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1736829806; x=1737434606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FOdtzYCF4PXzJzLjRup3D8rICLmH9SzW0xMwOnYJEX4=;
        b=OYXMMdQ5XZ7qQ1XF4L2h3ZAJcvy2RW2mgaLED3Wtk9/2CDKZ8EMwgQX8m6zg+a6TQN
         FhjLl0bkmasBbC81IQRaOkHpYxcmDAGY3w+O7Z73rFjPFK192rJiklBSoUGq4OFS37/b
         RZOTMVDjf/Hl5wtCpugEMQ6CWOvSKbuETIBfE342DJLgyqTccCeCUBJl/LfUrH9gn77f
         PEUHr0YVaB9+MxgEFbe4iw0TYVGVlPUwl/3ms41Yz90WqtQaAcR7TRtxyXG3MSt1mmZq
         ijwieZtrH5ROIeBN3avKcYwLQB6ORexbfyEpXA1Oz+Lsk3EisEQzGz993uHbumu6obOm
         669g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736829806; x=1737434606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOdtzYCF4PXzJzLjRup3D8rICLmH9SzW0xMwOnYJEX4=;
        b=cAPnb3429cMvr85bU8hak05BhaeZjJN3WGHz1NJ7eRu4+lyeNM5vaTfU2Ub088bZ1V
         yfnn0M6ygGb43OTTcyiSoHB6EQjfX3NqisvzJk+hSx2Kpfa6duwzORYSfC7XU+yrc95v
         JTI6ErMK3egO6rqOHRnG3qw+zg93GWl0QSjbn1rAGW+zK10joipLraOF5Y7sWIcaMVA3
         zWOVcXoy2qdAGcOWwsKpxJ2ANVcndnnr5T+miX7cN9i4yEEjJIGY6P418liAh/CsddXH
         cMV4d8R7pOHIo9SOcxAEj87txB33osQ7FnV3R/6juDRUbNeYsk2lc1uig2HoBpS9uFXe
         +vyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1BbPYpdxHXUoyWBrlJ8F5llre3Y1tpl3KWIa8FYol4AFxH1BOIy31nGNUf+WgB7sstjCjHJlFz33VEY3p@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc6LLomSvCPByG19iBGP/TlwEBcz29tnbyDBOCnU7/uXDvtJPp
	x6YpuzFMcEGbcYEeATnCebFeEkHYiTP9dZigoxnpzipacyQ/8FrQxYwONofEX0jI0S3WfmDZZD+
	E
X-Gm-Gg: ASbGncuDJsxtKWwK4fkkr+EJJWCkwXXE3NeVUZIhUKerRWj9yKCFdgkwg3by5FbNvln
	xthscue+7xUZa4BLwqFSX2pUrb3W9Y3PMALsFA5xm4j2rKwSzELQYllZLDI9/yMaANQToRZTFp9
	BOF639P6cf2qp5ZdifQmptY3lLk8JpYe6skToii/YaRwX9Q/ArpTfZVulq7MWAcUKb8JDMNGrTK
	6Mn6+9EXvxFL9atdRMvZlUALfPQWt0nN0VarfUv4o5fStyUtxFS9swe8GDgWh+yokuYu2pdJEIQ
	bXtXvx38YaSPwBwY9cZCsQ==
X-Google-Smtp-Source: AGHT+IFIYoO10KXTw0TKOC2xQh5bB6yv5WT3SHul1tP+v8nfNDVO8DNOzTyw/VSP/0d5X2siEOlP2Q==
X-Received: by 2002:a17:902:ecc5:b0:215:7dbf:f3de with SMTP id d9443c01a7336-21a83f5e4e5mr361278165ad.28.1736829806581;
        Mon, 13 Jan 2025 20:43:26 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22d0fcsm60480815ad.161.2025.01.13.20.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 20:43:26 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tXYlu-00000005cfW-3hFx;
	Tue, 14 Jan 2025 15:43:22 +1100
Date: Tue, 14 Jan 2025 15:43:22 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	dchinner@redhat.com, hch@lst.de, ritesh.list@gmail.com,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
Message-ID: <Z4XranZM2tCFbqZc@dread.disaster.area>
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
 <20241204154344.3034362-2-john.g.garry@oracle.com>
 <Z1C9IfLgB_jDCF18@dread.disaster.area>
 <3ab6000e-030d-435a-88c3-9026171ae9f1@oracle.com>
 <Z1IX2dFida3coOxe@dread.disaster.area>
 <ef979627-52dc-4a15-896b-c848ab703cd6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef979627-52dc-4a15-896b-c848ab703cd6@oracle.com>

On Mon, Jan 13, 2025 at 09:35:01PM +0000, John Garry wrote:
> Dave,
> 
> I provided an proposal to solve this issue in
> https://lore.kernel.org/lkml/20241210125737.786928-3-john.g.garry@oracle.com/
> (there is also a v3, which is much the same.
> 
> but I can't make progress, as there is no agreement upon how this should be
> implemented, if at all. Any input there would be appreciated...

I've been on PTO since mid december. I'm trying to catch up now.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

