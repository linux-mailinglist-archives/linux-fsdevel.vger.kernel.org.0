Return-Path: <linux-fsdevel+bounces-11488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA11853F24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BDAD1C228BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A54A629EC;
	Tue, 13 Feb 2024 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="0FDYyq3Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875CE626CD
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 22:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864595; cv=none; b=rA3kbc1qcVXjsr23pUqoCIH/OB/kLuK+3sdiD1oLsUatxCPLocHBDzKr53mGNtw8FsR8TfJRyqTRKGnpgYmmJ32i+oy+8qaJKCL+0AT7Kd7rnTcE6lHLuFt7rnGh10PjIryr576/bBWhfVq6JkN4VGnU5738w1SMaks0lPgg2oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864595; c=relaxed/simple;
	bh=JFD7xAow7H+1yh9xsxRl7E2QoaMz1RL9bCnrjaYHjXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKz9PZlQ3dCIIEHfx2ESYd/WgjRv2/JFO/r9s9Vc53I6egCcrLeG4G/R+dmQje4Z3WJzf4n/YYDCEmUW1MJZL8Xk5orQxsb8Erh0ijwb6nF+YLPGU9UMHPl8/F+uCzAf6fWSQra4Pcvuupp2anmCa9xrFFwfplI18dgyW2GrrJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=0FDYyq3Q; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e104196e6eso688984b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 14:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707864594; x=1708469394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZR6xzwDxqAQb8cigMZexWppAIVixuIfccZivtbja9cY=;
        b=0FDYyq3QxwDf32+2tnBeOUFctDD9+aIMufHxWPCsPwj63eYVwoCX4Hpm59zHr/M8EF
         l1s+yV10RrlJBPGnXgbpYSGD0zkj6ZlaQa6fPDin2lBjK7hLo5uhyELwVwrZg/bGkyx9
         GKA/CGMrfEmdNMzc6KwPeS3nsNSNYjJG4DZcWDqYeRuojcENRzqtqpiHadDkdXavkkHT
         AJ9rV6LohiOWfggAHCLpgtkoWCl3vRiGmYfxbHS1COF+Da804oxnaKn9PuEwRdfz0cxU
         vchTr07gZtqa8aBW9tPr/co6z4EAWS/ZwbPSfiIlpsRPaOaxCpH57C5iocCkdwhMPD9E
         ViVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707864594; x=1708469394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZR6xzwDxqAQb8cigMZexWppAIVixuIfccZivtbja9cY=;
        b=MSuj74rEs4m6HH7q5WzpJDvNZVNxBwh0gN/tHoaVkrjtVHy7pqYiFSBMc/ocjwZCAf
         RbsaiVb/KC5kmEs46ABUhZYurmHfRndIQ3nbJXnExS6SefwdKWKfkbbxVhJQrxlaOK5e
         Qy9C6OtWHJdsJ60/3nuc6gygDE72PG7RPB93uz37HkRju6KNZ6xnMQl2+7PabALAu7Wo
         3YqYuLqZbatgmIt4RR9KwUIhCo/n1/SmXy9ZddjT8svFP9jx5K9x8szBGYGf33OGj1vv
         rHAFUdDmgi95BuTxrr7a7zWowWhV8TsW7Eqc8fcQYplg7q00paqrPmJG8qi+W1Tltkv4
         w22w==
X-Forwarded-Encrypted: i=1; AJvYcCVfX2B3eAVBHkR4wJD/eMifAiIWYFExjm0CDMqXyOwQo4JPvVJne3uBE+AUhl2ZFId2KwCDOlZby2SwYQeXS7Du9qgkorQTSXvuAKt6lQ==
X-Gm-Message-State: AOJu0Yy4B3FswnaRtUyf3/Sc5IbdpvWd7iuSw5sDThpGxX8dhztHJzIM
	oBU1ebPsYCcVibh/BeLGTOJdPFjMQg6Fbj1Z1Ay0Zf0w9m0PSF81Chh5hLBzF5U=
X-Google-Smtp-Source: AGHT+IHZbMWPuooOSKJJauPzjg7QarbyV6SKoppm+MJO8EqpjzSzE7GGq86K3Tk34wf4BAMuyzp8cw==
X-Received: by 2002:aa7:8b99:0:b0:6db:e366:53a8 with SMTP id r25-20020aa78b99000000b006dbe36653a8mr616202pfd.12.1707864593791;
        Tue, 13 Feb 2024 14:49:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUfKkrwJXWRUEIL5OLcEDusRRGGYmLlc5RwxlnOogd+L9B+OOFNovbLPxcxqzpEzobK3+N5KMBN/7vIciV0LZPLeqtLpbuvffJbDDuivvlBZ/Q3P5vdfZzu36QMyxz94zsOKZzoxPk0RogHy5womcHgtkRCaJTLi7xXcadazDIOMBPiESTrkCsGnF6VMoO8zyz18MbQKOzIrJUv29I4qrj6inVHSRfW5iXbaC2gV8td4gjrZQxTzXIsKo4pGUXg4V+56vBLUknJ64BBQ1ira9KTAn4zsr0Ej6856EO2dZ0C9mWja7WF9AJfvYBGA1oIXu0y2KUb3cqFYgIBcKNTBkrw4MHlNOW3AcaUFxkFjhJB5riyxfGLwIiavfNJCqObLgh2tb+oBWG/eA9OIkmmpFJkb3LslpLgYHssqUYyFJmIIMH8+d9JNv/nOjU7KTDy0mcq6u/LjXegOhrLVVXDzmZtzGN2g==
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id x20-20020a056a000bd400b006e0cfe94fc9sm5385175pfu.85.2024.02.13.14.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:49:53 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1ra1b4-0068Pv-1V;
	Wed, 14 Feb 2024 09:49:50 +1100
Date: Wed, 14 Feb 2024 09:49:50 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, hch@lst.de,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
	martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH 0/6] block atomic writes for XFS
Message-ID: <ZcvyDnUoC3PvV+p8@dread.disaster.area>
References: <87cyt0vmcm.fsf@doe.com>
 <875feb7e-7e2e-4f91-9b9b-ce4f74854648@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875feb7e-7e2e-4f91-9b9b-ce4f74854648@oracle.com>

On Tue, Feb 13, 2024 at 08:41:10AM +0000, John Garry wrote:
> On 13/02/2024 07:45, Ritesh Harjani (IBM) wrote:
> > John Garry <john.g.garry@oracle.com> writes:
> 
> Does xfs_io have a statx function?

Yes, it's right there in the man page:

	statx [ -v|-r ][ -m basic | -m all | -m <mask> ][ -FD ]
              Selected statistics from stat(2) and the XFS_IOC_GETXATTR system call on the current file.
                 -v  Show timestamps.
                 -r  Dump raw statx structure values.
                 -m basic
                     Set the field mask for the statx call to STATX_BASIC_STATS.
                 -m all
                     Set the the field mask for the statx call to STATX_ALL (default).
                 -m <mask>
                     Specify a numeric field mask for the statx call.
                 -F  Force the attributes to be synced with the server.
                 -D  Don't sync attributes with the server.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

