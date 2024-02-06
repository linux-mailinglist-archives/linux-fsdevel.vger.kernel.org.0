Return-Path: <linux-fsdevel+bounces-10525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D41C84BF69
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 22:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB621F22ED8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 21:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EAF1BDDB;
	Tue,  6 Feb 2024 21:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="od1fIqTV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A5B1B963
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707255930; cv=none; b=S2MhNmDqMld6CNXtXSxvb94iB/F7PD9QIoD1hJPZkI5VDKY1uOf3bBNPN9xem1buC9z7Ke28ILlnawAR6acvH/edzOlqAVf4rEGC9EZszdgJb7GWthK3mjXWBRYiPHDzoaVhMOj+BDQzwTKSvEROemVc25UcFAu5vwhggWfaZ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707255930; c=relaxed/simple;
	bh=xpuii4QfzD4jEzhevZ2b9XTvvreUdctw2OZyf8mfP9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KChLmly8S1OIuIk6idP6vnZij6f5/K+TAgYsk6y7gHEXdh1PSTv3GrywoM3MMwTN1wGy+SCQYaJKuHDZHuKXB1SL9nxMTx4QcXmdv+t+q03nnNMSASGWO1GY4sN67PmQKLkJcDAA+OQOScauDE2pGd6bCihwNUiEfGTK/zt4sdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=od1fIqTV; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso5445397a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 13:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707255928; x=1707860728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/37JSjbI/f2Na0qgTL3Rfe82qOF/glLP8giIUKBuBFY=;
        b=od1fIqTVxRvosHTsa1h02d85nsYChjnp9eUqQAcl4Rsv5MNln1BPD9vur/ZK8PoY48
         NWn0ad5u+D6Kj8Ulg0ETsw2yCUQPrC6lsTzZ24GgxS9exmBkz8MV9NsC4JAEfk7Gv8S6
         envq8elCCy7t9jd3lLqg7HyUMNqYPzVZR+WL8waP0ZKPtoIsg+0P1+OVqRAPiw5hqC8f
         ZO9QrURxlDiYCxFQ9kM2U8njWZ/NTi7giITQhiW6o+i009HkBxX0Dijp07qu+V1lhjsm
         iATBJzjMrnUSyqxAT1EBwxwzrMhvJ7okKLYVRjB3NDPOjHyg5hTPZ+F7r6fkL/xtTwP4
         /7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707255928; x=1707860728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/37JSjbI/f2Na0qgTL3Rfe82qOF/glLP8giIUKBuBFY=;
        b=p8eQKjlbi/wiC3XwId+e4/B22o3S/7SgJf85YleNqq0gSZOJOUkT1PewvosgQKhFa+
         k7EKtzV6Cx5mXCeSCFqKFfHxY0w4N7DL6ErJx3nNNS8ltLWOyYozlcSt5Ta2f6/nupzj
         S/C2YxOKVIpssZAWumXsCthwPVSAyT/bUcb/+V/+ecL6UFDbqx5/xJycpBk8MUmEYdnI
         HAhU0+CdYXUJqZWklzXerA+oxasmXaYjRIrB4/MLCoRvX03DXl5Vj/w8SuCwnMB0T4Py
         tX4xwbIL6HvG5G9Cmmp7rZHT/46TpwO9INPCLRmLC3mMwH4JSloTiI5QyDwBS3rbVAHf
         plpg==
X-Gm-Message-State: AOJu0YxEdXuF86UNMTa3vDlJ96h+0XnLfWTMGe17CYnB4pd7J6UyXqHW
	3PrsIrsOf3hXfURWASFqRyOReJrtjHo7Uw4sX2Dr3wWL5PTvwFFe2XE40PtMF40=
X-Google-Smtp-Source: AGHT+IF99f+jeKrX/4alc7leiUZP4sxR7/84dgDSY95WF0/8JXBgYKilv3tE/LpCTOTmHJvbL/At5A==
X-Received: by 2002:a05:6a20:da97:b0:19e:a499:e062 with SMTP id iy23-20020a056a20da9700b0019ea499e062mr3810pzb.17.1707255928479;
        Tue, 06 Feb 2024 13:45:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUqB8JMgSg263VaHsvWZS57qq+8QlV5qioXTtYkIVXvpOiXJ0SqeigAaactbx3cQhJhtkYZ+0FajkVGB+2CTdKZ448w6/RFAGOWnXJ79nSrMDS7ZEKyZiFZ46teSw+gbQaYJXdRfB7zgjmNAQ==
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id f7-20020a635547000000b005d8be4c125csm2621486pgm.80.2024.02.06.13.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:45:28 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rXTFt-00305D-0S;
	Wed, 07 Feb 2024 08:45:25 +1100
Date: Wed, 7 Feb 2024 08:45:25 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] fs: super_set_uuid()
Message-ID: <ZcKodR+bNWY8/dCI@dread.disaster.area>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
 <20240206201858.952303-2-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206201858.952303-2-kent.overstreet@linux.dev>

On Tue, Feb 06, 2024 at 03:18:49PM -0500, Kent Overstreet wrote:
> Some weird old filesytems have UUID-like things that we wish to expose
> as UUIDs, but are smaller; add a length field so that the new
> FS_IOC_(GET|SET)UUID ioctls can handle them in generic code.
> 
> And add a helper super_set_uuid(), for setting nonstandard length uuids.
> 
> Helper is now required for the new FS_IOC_GETUUID ioctl; if
> super_set_uuid() hasn't been called, the ioctl won't be supported.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

Looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com

