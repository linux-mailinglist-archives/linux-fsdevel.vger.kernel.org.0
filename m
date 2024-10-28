Return-Path: <linux-fsdevel+bounces-33069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC219B3258
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 15:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2701C22B16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 14:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A239D1DD54E;
	Mon, 28 Oct 2024 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="VtOhGLFt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6BC1DC734
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124053; cv=none; b=BJclPjEwBoSFq35sR2vqTpRys8l7GKfykAM4pNf2gIexSuDRbx9DHz9CDxqO5cYHKG5oHcXWYLcSnhszEgI433z29WQczWO+lyXFz9kpbuLjNMWLBtqlB8Qqn/MIX6le8BiDhORN11GjKzqyRgo3mfr1+oEYjQfkcWanOjoqloU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124053; c=relaxed/simple;
	bh=Ew7uv1Ej9gxdNQJgHdVVARFS6iEQx+F+aZ8qXNu4Ti0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiTTOrel0Xsevh/yeis+MyNK9ghrpahftvQnJlW5rhuHmM/EA1bgUULY0Zdp8LYkU/hoE7pw6KhHUOASChQtDh1sdx1bMqz3YaBfLU6Ocfw8oK9bnQFXUFl2y9YHBU7gOvX4LFf1OFoO9KpY7DOREN6pcIGcASWeJ0lF9QS6oDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=VtOhGLFt; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ebc1af8e91so2141358eaf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1730124050; x=1730728850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5CyyWAppIMSemT0CuK62Hzyft+OY6WztWx8opHDh7Gk=;
        b=VtOhGLFtMRINgCVX/MFbzoAWe/kNK7gsR+YtXeb7ibCI3qfQPXBfnw8go6Otz+5C9/
         FaKvsdwrUKETyIE06QSa/6ojAKM+TmqFq9WBw9ADBLdMyPxEtDr+ieb5PR1p9RL1XTTj
         1zQELN6mahRrknLnJiY1oXkJ91IICjMk7iiVgBA3sICGEmmCdi7r8IF42aOxLME/M8tY
         GBIk0xXxbyWuvA9IMX6uQD5LyOqM8fWEUx7OOefeseDwcf1+sW6pZWAAxQzytNmZk6DK
         vwqO7LDNNrvrw+Z5fhTkDc2HNRf6NWqYXNEK2+ilNxMtu17Wo+k5OCYNDCl6eP7kAdp2
         0XDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730124050; x=1730728850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CyyWAppIMSemT0CuK62Hzyft+OY6WztWx8opHDh7Gk=;
        b=OBljhtySXmOVEFSzcYMqumspKH8PFpPzZYH2FB2fxd7TEbB1avLg1haXwomadBLxB6
         7N2He0Bw+bhnnrOdDggTaiXzgzeyzTpCK6EoFrcu2IGfhIra8JA/5SxjuyOlC7BmZiDZ
         a5Q6b+pUwsucKc2zJMbdRTUcp8Wn6uX6XDrrXvNE1a0G6ZKTHFhjNiXehUkcwr0443mX
         UuwUS13WjXOxoQIFMC4UtqscvPT6YwWZu+4pax7oDU6QsPlfhXC6LdPsZgAgXXQzSYMh
         PQ6PlzSiIoG2ISNmC3ksT8TnrfYWxVl6kLJsBndksepG4FbC0E5Z7GCoHIr/tzQ0yCDc
         xlbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJsPlOp3o8L4dCAyLCT1knivYvT5LvIksN7Q1J/+5pI/Sdya5hTze6uR5Pi46jcFIZE6kJbBWo8dH7mxjb@vger.kernel.org
X-Gm-Message-State: AOJu0YwR4k1QAGxQsQ1gydwY2Ne3MnEq4pNUbFc5lLzgwzA37gpJhZiU
	u84eCEzI4Up5Po/fPH29aeldSzb9Ws2dBt74fCKJumGcgZ29ANpwvaUMV2M6A3E=
X-Google-Smtp-Source: AGHT+IGBtH1NdyVtTtxosvWgimQBcEYOE5uA1gln4dVd1rWRKzOv+q6qmhcV6IpETFtUChiH4J473A==
X-Received: by 2002:a05:6358:e4a9:b0:1b8:6074:b53 with SMTP id e5c5f4694b2df-1c3f9e18e55mr223282755d.10.1730124050180;
        Mon, 28 Oct 2024 07:00:50 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d295ebasm318533385a.50.2024.10.28.07.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 07:00:48 -0700 (PDT)
Date: Mon, 28 Oct 2024 10:00:47 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 4/6] memcg-v1: no need for memcg locking for writeback
 tracking
Message-ID: <20241028140047.GD10985@cmpxchg.org>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-5-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025012304.2473312-5-shakeel.butt@linux.dev>

On Thu, Oct 24, 2024 at 06:23:01PM -0700, Shakeel Butt wrote:
> During the era of memcg charge migration, the kernel has to be make sure
> that the writeback stat updates do not race with the charge migration.
> Otherwise it might update the writeback stats of the wrong memcg. Now
> with the memcg charge migration deprecated, there is no more race for
> writeback stat updates and the previous locking can be removed.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

