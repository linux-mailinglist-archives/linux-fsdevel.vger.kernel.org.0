Return-Path: <linux-fsdevel+bounces-45390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72107A76FCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 22:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B673D188C852
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 20:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A15821B9E3;
	Mon, 31 Mar 2025 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2NUK/SsA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05252214A7B
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454687; cv=none; b=Rw+9TIHXsZq5ewKTJ0enJclTs9HCEJfq2f7nGVERl6pdlxygLFu2Uz+IoOW1RvQlNy88oV6HHLtTTjVn/K8kdWWBV+oAj5qmKSZfR1xsELtowe6na+Z2kGvGfoFT6hRjVRlLG7qQCkZ5bQtW4wJSZDODthoHeW4J/6tA6kno0Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454687; c=relaxed/simple;
	bh=aGNIx99XEZi26AFkfCOBDo7LGAYGpiu5frRyAvVPpxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOxJZqPhCcSQ6AAHyipIb3ur3cTVFd0zBThY6CN8l0wdhxt3/Gj8nlIcGE/Z264LGqyyyNxFaQYP4o6aFUT/9qtWnMKGGW7p6ST2SN6g56Z4p3VUb33MOW/cD28Cw7/dZXtg1WpRyYCSQLhQeMd/Q2QTVWQhhFIAav8VzrqRGZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2NUK/SsA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223fd89d036so103451625ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 13:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1743454685; x=1744059485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rKR+g8ZaIWjhBn9iMd35DEz0bSp4f98WiNxMgEiv8uA=;
        b=2NUK/SsASDQcaK2u+cZIgsnDzxxyET/1wwTGOb9mt4VHxWSV5sFzjPix8m0EpfXUx4
         DgGzqrC2OB9upjjL5Jz2HHO7Ohl1ec9IcLTPB5BNeln4sNYE00MIJozprkpndNQzCYdT
         CcvSPij+G9uPOecf8aO4RaFWtHuX0dgoyjg2DFth57LiByrabW2V2j98794Cf5JuIW5E
         MyaInPKbdiUDHWkN0Ej5YIG+/r0zMaKzjQfMAUUfYVsIrIya0HehVi4NM5D0TnjxuFyc
         AzSuYAdgFhOZuiJtowFNfBXIFknVxqEeDzSin6yrmRql/YgGzcdq0mwhgEDxBGhdHOg9
         B/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743454685; x=1744059485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKR+g8ZaIWjhBn9iMd35DEz0bSp4f98WiNxMgEiv8uA=;
        b=P83iJtvZqt/jMWUz/50VudQjqUFKsXCRzZdfdHWhjbhvjWcL22s6vAUZuYHtP0kCYJ
         9k7NfvA8OI0JjlrWDBDgMGgqO23BgQBVWGaN2Erg/vc2POJK77uwJmri7vQiqXyCOx2b
         OHeg0TNwzGAk1XN/4sMWriCf+sCKh/xDsQrW63ZQIighaO63gjhxyuVyLaor+94DDIBu
         WWvdThtM+BfxAcF2oJyYXctYxM09JS7KrpyYbHtLRqc6rNvG+NlQXYfwk6XbvylISEbG
         9DKWdii+FzbmjQN0XyiRMnYx5vh7lo1hoIXiT5gCijVqXrv5xYv/XXZkm0R8UxIYw7c8
         0XOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg4kDPBxl6dlNMrreXhHNilUPuSg668s1rRRQCjNdaQKNfW/3njRPCZzDIaChZ8JyODd4EOSVdzqC1lQUa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx07TaasboY3gjDNaIdCfY3vOUeeAZjIOOSEc35As3krGMT90FT
	r+UiLGPONyoZ/jW3xNGn4Sy+iUNyDNklJ0BoVeY1tH5rXzOBADPO7vM7IRPcLdY=
X-Gm-Gg: ASbGncvGkKe4tZeWytXPg2sFeRyo+9M//xTj1IsWbwfKENRARRjiKMazdV7FoTSROxt
	pv996m2mxox2OkwKiF9ptQrUWw44DUNeh+rHl0nUPDDIYCcX8vkaIzjyC9vE+OFmviLLfrUuBEN
	+xFH7MMupT9sOLLvvAWaQH6xxBWasIcNvUSQjVkPvpgJx5VYU5MYAxMvYmniVxgbGMuWySQM9Hx
	yAFTe8Ngzz4FicNoUnuJB683p0z4PMW8T0ObxubXSBbb1zP0vKUw4SKKE0cmCnc9xQ4i3LNEvhG
	YfR0MZmuA+i8m7C/r4MhaBGtTzsfsew8rjQHIe4dyrVpqxp433JmbNMTjpqfgAtyjiqGorqFG03
	TftABixzdhzf3f7WtOA==
X-Google-Smtp-Source: AGHT+IF0y1YF59gqB0AsgUdcWNQsSB2cHQcE0xeypp1zXbvwSPtmqTmVKsrm5stI9OGLQ8J14fw4lQ==
X-Received: by 2002:a17:903:2311:b0:227:eb61:34b8 with SMTP id d9443c01a7336-2292f9777d6mr153305955ad.25.1743454685038;
        Mon, 31 Mar 2025 13:58:05 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eedfde5sm73934285ad.78.2025.03.31.13.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 13:58:04 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tzMCn-00000002pXB-1yFO;
	Tue, 01 Apr 2025 07:58:01 +1100
Date: Tue, 1 Apr 2025 07:58:01 +1100
From: Dave Chinner <david@fromorbit.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] fs: prepare for extending [gs]etfsxattrat()
Message-ID: <Z-sB2XYNlEl0u7j0@dread.disaster.area>
References: <20250329143312.1350603-1-amir73il@gmail.com>
 <20250329143312.1350603-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250329143312.1350603-2-amir73il@gmail.com>

On Sat, Mar 29, 2025 at 03:33:11PM +0100, Amir Goldstein wrote:
> We intend to add support for more xflags to selective filesystems and
> We cannot rely on copy_struct_from_user() to detect this extention.
> 
> In preparation of extending the API, do not allow setting xflags unknown
> by this kernel version.
> 
> Also do not pass the read-only flags and read-only field fsx_nextents to
> filesystem.
> 
> These changes should not affect existing chattr programs that use the
> ioctl to get fsxattr before setting the new values.
.....

> +
> +#define FS_XFALGS_MASK \
> +	(FS_XFLAG_COMMON | FS_XFLAG_RDONLY_MASK | FS_XFLAG_VALUES_MASK | \
> +	 FS_XFLAG_DIRONLY_MASK | FS_XFLAG_MISC_MASK)

You might want to fix the obvious typo....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

