Return-Path: <linux-fsdevel+bounces-12565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D364861231
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 14:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF8D1C22CE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA4C7E0FB;
	Fri, 23 Feb 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQ5GZ53M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260107D41D
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693366; cv=none; b=F6dh5qeegbSpUE1MPzGWMXKCO0C9/nnHqk5UyvZaFhgWAWXxVvrKhGgW1QfavoXVcJ4XazX6IuAz3LWTF+QsmU1tZJ/yYXVDO2D0s3wF2SootkTZ/WbijjGhxvyp38kEkvZaMyc7mK6XO5y6bY6091xO/UzpOr8U7pgNx01hE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693366; c=relaxed/simple;
	bh=RUPGz4uWHNl3T0qSIFmu8luoF5GX7vvcylxL8fCjZrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVZ3+zHSFc0qzO7xc6X3DC1I/Oa+6CJ3iBB1GR1DlQ7fxR2+D/pi6Q+jXzQPw8BX0VKy8w3GGVVnKN/MYnZlCMvEAgnKe6DIXXMYYa748+WkW7lE9r/xa2WkOf5NbKBU62fpGtqzZ+ABeP2sH4XiXraRB48h1mqVY0wPtSVJ+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQ5GZ53M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708693364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9nNIDOJ7U57ZqFG+S4c1ph7aQNyUgoEFYAGarXzmePc=;
	b=PQ5GZ53M/R1sthy6cUFARcWaypZB1+rVjhOioEtRPyLUr96kwb2A1qALI5/h7qYOge4H0H
	e0vKtUStAfYEy4cTnkQNX/dHENBPvGo3RzDPOWf8Oow/p5j776x81skkNI3x6XQ2O+BMCp
	nlA9HPWTadyah62IjBAcAvtOg/uZsNw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-ISdNX7URNKm29FcjnZg6BA-1; Fri, 23 Feb 2024 08:02:42 -0500
X-MC-Unique: ISdNX7URNKm29FcjnZg6BA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d73e15097so343838f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 05:02:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708693361; x=1709298161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nNIDOJ7U57ZqFG+S4c1ph7aQNyUgoEFYAGarXzmePc=;
        b=Csukts5/H6RFMTbNAjRP3jzysXzu8QfxWlb6zHOZ6NTtXCOoyxlzH++EsJCviUAOQi
         VDF0zy4YOwfDocWInaNXMjGpFROQMKiqm0mq2JiXt6AAcABhw+8c//qnipf26dbyICSv
         RaRFXkfg/462zm173Dn6LK6KkjBD3TqM0CkFVpqmIa6jDnObc4xe+AIsrxHw+uzcvfwV
         dlcUPidqp1q+wc7Q+N8EfH31Zc+KmogKKi4/w0sIPY7cOoCsNTXateY2mRiEQ/ICban1
         FcrpYu3I44bY6XY5ePzz0YxofPfW5Ok8mRHs7WPLycuLSgRPhicvXIGhChU8oU8oILzo
         kKfg==
X-Forwarded-Encrypted: i=1; AJvYcCVjgG+mSbWSRZyooOlAPgJ3IyVGygM3XWdqBW0lkBq3MrMT23K0bcn+h8c4X6ybVZJP/9mUkmsOhr3oI5eZnVQS7eZ2hWzAheMn2f1BdQ==
X-Gm-Message-State: AOJu0YzZVVkpxDkoVldn4HtIOttVVZ6mALltbC1SUehS5k9qLI9JOz3s
	x7CFOOk5VGRIN9mOkPLg+yGZAD4uoTTlt9a9j88xDGDZ+HtKfwrWq/iBy5V8rFqWqZ0JzPrq83j
	TfHwOLS5krzTo/B2tAZ2re2LeFKu9Lx0wFx6bzHI4NS2WnWzquA3TfaJXI4CmRg==
X-Received: by 2002:a5d:4746:0:b0:33d:9d22:1fdd with SMTP id o6-20020a5d4746000000b0033d9d221fddmr3095867wrs.19.1708693361510;
        Fri, 23 Feb 2024 05:02:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/fELhAmOQKDfpkAa81QRAjueWrbzCylz2IBIfn4SD11H+AbnP2lo2q/006BquKc+5pg5jPA==
X-Received: by 2002:a5d:4746:0:b0:33d:9d22:1fdd with SMTP id o6-20020a5d4746000000b0033d9d221fddmr3095841wrs.19.1708693361166;
        Fri, 23 Feb 2024 05:02:41 -0800 (PST)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c3ac900b00410cfc34260sm2345848wms.2.2024.02.23.05.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:02:40 -0800 (PST)
Date: Fri, 23 Feb 2024 14:02:39 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com, djwong@kernel.org
Subject: Re: [PATCH v4 06/25] fsverity: pass log_blocksize to
 end_enable_verity()
Message-ID: <ejszyutkoujv44mdmeyzvwdeqxi4z7a4crtfpdxddg7wtvjvth@jgtnqj7ginge>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
 <20240212165821.1901300-7-aalbersh@redhat.com>
 <20240223042656.GB25631@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223042656.GB25631@sol.localdomain>

> There may be many Merkle tree blocks, so it doesn't really make sense to write
> "the Merkle tree block".  Maybe write "the Merkle tree block size".
> 
> Likewise in fs/btrfs/verity.c.

Right, thanks!

-- 
- Andrey


