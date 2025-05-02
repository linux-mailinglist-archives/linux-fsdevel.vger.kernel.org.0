Return-Path: <linux-fsdevel+bounces-47903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0396CAA6DDB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 11:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AAD54A13BC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 09:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5087B1E487;
	Fri,  2 May 2025 09:17:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B6038DF9;
	Fri,  2 May 2025 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746177424; cv=none; b=ieAnSnafXPWuel3vDzRSR1Xzc4LseonJm36JM0eCTycJdI6RNUFptjEVwmkPkO6Lp6OBX/JP03rAtp1LDyyfTGLxXlaYtsCFiWhrIJ6kJMBVVHFMg8fLAULVFcYsYYZJ7me7MvHGeFHMPjz+AOBIhQoVurxTwGUaHQPKa8uKfTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746177424; c=relaxed/simple;
	bh=h1UF7RGtB1Pbog0NUMV8tDJBLwjc+mTRVhKiphrplxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDkjXstuT77a4lWUssZvqjf2w81fms7jmuX3odxf5kCx3+Uz70Ej1i62Msc2tDeb+jMKXF7uL1wXdeCy3HBIWBHyq6rlZJtoqJYPTUXUC3uUke+ePefZz13RoMQuozcA3o7Y9hD+AddpsjZBEx3xVLvEzrPVjrR9Ls5axu81f+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c0dfba946so1317450f8f.3;
        Fri, 02 May 2025 02:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746177422; x=1746782222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1UF7RGtB1Pbog0NUMV8tDJBLwjc+mTRVhKiphrplxs=;
        b=PFw/QktCSKVBMbpVIL2TnysML0Be6TpgKTERDqDRMYPkMXd8oTqbKoULbwsQlVr5it
         HVUHvlxdbno74HGMWZrdAHSz3maWVpEtsy2vP6SULvDtMo3S0Q+QfqClCKyLT5vt+GZ+
         VJyoxvHj3TAsgf/3u8xOqN9Z4CzSAVGj7gLhFJx38TtYO5sK3N58oggiS8dnOH0C27/A
         aBTTKgGKevYeIzcuDhKArR5lDk+kxrzIbfiTFGt0r3Jk/1/7iKQ2/7ARsHwrkp9gh81l
         9tByTASJbmUSrFT7m+SaQ8KG0WC0KrbV+DtpLfTXun3U3E8vdCPRY+Ysk1akf/VWVsjg
         6c/w==
X-Forwarded-Encrypted: i=1; AJvYcCUDLUQgkzZBxOc21l4Azy4B5Ulf8P6OphA1sMGDNFrUa1zdXHXSMH3/pWaJo+Df/Lu6TSTIX0q92uHFjFQ=@vger.kernel.org, AJvYcCVasYz2iZKTcwJZRH4cmOwIAqXo6A6V5TLDcQBHgrYVwU+pLxwQmU+zNTEV0n82IdoI39dyiAeP4bm8q2A=@vger.kernel.org, AJvYcCVsSh+juvu4+QLwoYkW4m9aCKeNBtEQEAip4y/P6WD+xmuu3E/qKV/U8D9LLA2jAUafgBTUvHpwhTQ=@vger.kernel.org, AJvYcCWtI+g4fWLiIiqP4VAuWdYf8PsfH8Fh342i8d8ytbHpiUqWw1MOyt+017pWY9V0jI9xnwR91qBm7xWzRZA=@vger.kernel.org, AJvYcCXcUmVYfuJHOglt04f7SUA74nkBW35dwqOlAZquF+o/ClBO7q2YksFy3eOgWTnkxtWJCdrtBkDksCUm@vger.kernel.org, AJvYcCXyl3jPw0FAJyzgfDXEyqlv7LPs8JDsBrlHjwcbFhSLOiQeUCYe7XmdMmyBpwJxyts7GXQXkHAZhHhmoRxVFw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+r7gpcVuguxGsRCzzH7S87D9PozlRA1upGUh4O2spWjURzRQA
	xtJEIRcPBMNbooSs75sihOdIlsaD8xKoA+qEV0iRG/83/b83nXTZ
X-Gm-Gg: ASbGncsFkhWrYMQTPyCQ6Al753Q82xaluIOvKG8YKz4qThK69lKt/7zZtTW//woyKK/
	CzGck2P3DCA7C/PRxAYa9IMDWN8VG4sWK1sFa6B6r4GSblT9b3WTP4Vyv6JaraSOkAWPgjL6EgR
	RaZXgodupCjduMfCX/IVoFsftjAJmnvuSZvRa1nAEFiGxmYAdLzIkUq2WC2rzoENneDjJk5Q2UR
	Yb/8O+ZlCXXzH5ByHfCuGzgaxr+jGheCkGIJKv+pSmO7XNFd8vFpJq5Otr7eUroGk3j4YNHRccd
	qixcLEVlCTVQGBcZEP4Vn3YpbVXDDjDfsqgcmT79O9frYt0U8iqxtIMfO2dguqcYhpRF
X-Google-Smtp-Source: AGHT+IEHr91C4bNBb8k+B1Z8eJ4KnpjI8/kk3tpJZFK7ufLvYFKZ3M3NwP1v7B2vBEKWAwYg88p13w==
X-Received: by 2002:a5d:64a3:0:b0:3a0:8acc:4c5 with SMTP id ffacd0b85a97d-3a099ad27afmr1522259f8f.9.1746177421620;
        Fri, 02 May 2025 02:17:01 -0700 (PDT)
Received: from fedora (p54ad9a78.dip0.t-ipconnect.de. [84.173.154.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae3441sm1553880f8f.26.2025.05.02.02.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 02:17:01 -0700 (PDT)
Date: Fri, 2 May 2025 11:16:58 +0200
From: Johannes Thumshirn <jth@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 03/19] block: add a bio_add_max_vecs helper
Message-ID: <aBSNirClYlLrY-fN@fedora>
References: <20250430212159.2865803-1-hch@lst.de>
 <20250430212159.2865803-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430212159.2865803-4-hch@lst.de>

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

