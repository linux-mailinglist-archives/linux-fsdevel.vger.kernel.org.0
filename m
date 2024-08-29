Return-Path: <linux-fsdevel+bounces-27706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB74A963696
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 02:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855A71F255CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 00:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DCE5223;
	Thu, 29 Aug 2024 00:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="WPJrT741"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2728733F9
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724889858; cv=none; b=noj3QPmrWLQeL1pYX77YyTmVIl220DxLAuuIcqa2JOoh6onvhYlNkKgF1pXVxepkVLpMfYB1pg9W4uobwcl97ttIXAxyRNqiP+Nb9D6JQS/1it9Xug+A5HJgo4k6sc+NCcGpsMQa4S/kEhkFOWjyN4hmUuTs9tcpXCJiOXhLdw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724889858; c=relaxed/simple;
	bh=KyLGQwTZGJI9C+TxeuHIpD8SWXxB1XO3jiZioo1F7D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9fXfkycRuRJDKNPdc0krHmF0TjXyo4aWRfllTc+bl9bPlEkqqsks74Qoia68YoilK7ZgYW3ntjFmMjANdHJ996eJUUuLkuB6C7VG5gNLiDdzlfUCJ+UdcRRhPHJT8TFfOMUhYjD1CXHNF7a1y5GYWisRsLO0EiznvG2c1xa3F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=WPJrT741; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7cd9e634ea9so34571a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 17:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724889856; x=1725494656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=COR1ZqmS3AQGVeut7VtGGClrfLqRYNR7fLk6CKT5PI4=;
        b=WPJrT741Kwem/YYhPRldzkzgHB5dvPiSshEafC+wc6Ye+MGcox7urBMfTfQsG4Qau9
         a7eKOsLidFe3spt7WeOj+lHyT4eKbH9jsxpeaOChA4hQIRSCipFcb41XmyPfgrML0clw
         OPd4GuDRRMkDtkdSzknD6tm2hbUHP6XJgTza2y8NtUsZSd612rrxA/tIKaHwtVUYgOC+
         GYI1WRWo/gvPKAypeXpklWH/Xl+CYaNGXQtO6YZmK2Xt9/J2jus+3rf2OP6Wl8/FSxQt
         ilTNW4Hl5Kex5uTdEOeKwkGaq8llNjM9HKFN+u1xBjxnYe+v7srNuJinwQnN1jISQhye
         j0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724889856; x=1725494656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COR1ZqmS3AQGVeut7VtGGClrfLqRYNR7fLk6CKT5PI4=;
        b=ZPRGebcIkRWa2Ppx65WEmfk5pjp0OIBeEhRD0Pf1f3zmEoMq7C6JRZ6bDuUTdn6pT2
         swf+8kXBMVkCC0JAi6joEXl32tLzZllluRrBfV9Q6xNfwVQeu2DWVitaKEL/J+9XyaG7
         Uz4efDEQag6j8Yr0R8U6sXVJEyj4KE9u6m2plFfTVwO2a0KNHHmwm3WL466wnq6bcrEO
         KpeFz/rJgMPRJqGJJ3bCfJ81ZAAs9cEnvBSVRcsdmy1kcyrtueUYQHO365YfGlOUUzLY
         OlrkPe9MdDyCo6fhYgBQGrKws3VzxYw006kEcD9gKaiKSAESPqxq6f2wM/XCpYKhX9o8
         gwsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGqlEEeEaIapOL8ipPExekUbGo2UHVff8YrbNyOWg1W2oEywOJxCdLQLWpfGHkXRm3y4MddOLfxyarbxbA@vger.kernel.org
X-Gm-Message-State: AOJu0YwEtspotLBMI0IHCCZFnT02PEyqY4Qz9ZW6KdTmw3AjUoRXHRqm
	Wf5EuuR5UjNTMOKm6jMAaSaTjGuQpCk3IoBs4S+qBIm7ipT4e1fHQwFethb8z6s=
X-Google-Smtp-Source: AGHT+IESVtnSdQoGTtnvbTVpwEWjdV+tkWGCRLHYP6jmOdg96CuYPp8JZaVaqrUyxhZNkZKqqlFNxA==
X-Received: by 2002:a05:6a20:9f8b:b0:1be:c9bd:7b8b with SMTP id adf61e73a8af0-1cce10fdd22mr972281637.45.1724889856257;
        Wed, 28 Aug 2024 17:04:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515543fbdsm384775ad.218.2024.08.28.17.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 17:04:15 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sjSe5-00GIxz-08;
	Thu, 29 Aug 2024 10:04:13 +1000
Date: Thu, 29 Aug 2024 10:04:13 +1000
From: Dave Chinner <david@fromorbit.com>
To: Anders Blomdell <anders.blomdell@gmail.com>
Cc: Chandan Babu R <chandanbabu@kernel.org>, dchinner@redhat.com,
	djwong@kernel.org, hch@lst.de, kjell.m.randa@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	willy@infradead.org, wozizhi@huawei.com
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to a24cae8fc1f1
Message-ID: <Zs+6/fZRtMAfI9ya@dread.disaster.area>
References: <877cc2rom1.fsf@debian-BULLSEYE-live-builder-AMD64>
 <1037bb5a-a48f-47cb-ace7-5e0aba7c6195@gmail.com>
 <878qwhl2l5.fsf@debian-BULLSEYE-live-builder-AMD64>
 <9e95498c-3924-4865-9012-ba92c4f4cf48@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e95498c-3924-4865-9012-ba92c4f4cf48@gmail.com>

On Wed, Aug 28, 2024 at 02:15:58PM +0200, Anders Blomdell wrote:
> Dave,
> 
> Do you mind if I CC the path to stable@vger.kernel.org (and maybe GKH)?

Go ahead - I missed putting the stable cc in the patch itself which
would have triggered an automatic stable kernel backport when it got
merged into the mainline tree.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

