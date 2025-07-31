Return-Path: <linux-fsdevel+bounces-56423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2F4B17383
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 16:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CD0A83511
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C813B1CB31D;
	Thu, 31 Jul 2025 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyYviVzf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FE815573F
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973694; cv=none; b=aDlqng8NBzJ2iHMcEwsDyb8n80Ar/wy7mK8zONd86YX3lgfHRgTgFaBj2+xYU7dLnYhKnxxLobDJrc737WRZI1WczICYjOIAMN4+3KHFQP0IitIKOGqqvVtwT7If9JdeTYvNE7cwFpHONo8OsDldFXsuNSkL2+hEtIy538VEwCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973694; c=relaxed/simple;
	bh=PTsHhQ/kGe0Fu+dlTBpQcyKEL+I08vmxkGV2copBL7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIG4Ffy2ov90S3S5JWPBpBiK0KhZJUTrcNUgeDXMIjmCuwm/fPclFaHH6ocp1bH3gDqX2wEv+2E28t60artZQb3SHuxLpOxM5GA/UPb6MvKMM63VZbSD2drHHeXl6/xYuYglLk17hnu2UuiJrCX+xpPRS6bp+hgHEMqiIaGm9VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MyYviVzf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753973692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BrfdQfBwi1hWO79GIcUjuPsQVqZpwzL238pikFlNxhM=;
	b=MyYviVzfWnAVf7chU1pPTbu/x3AG6hH7vyrkV6HW6kgpg3Wq6XyoFeR5+NckKyTyrb38Ee
	7JShpqovwohTllb1ImbXzznWe4D+kSPzUc+DUNzI/PZX6WNy0c3Xqwxl9HpKW0EXNVz7qj
	jUhfW5arWgTN8FtMhSe9f13uGFNIGF4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-WD0rXxV3MQ2Ma5gqhMGY_w-1; Thu, 31 Jul 2025 10:54:50 -0400
X-MC-Unique: WD0rXxV3MQ2Ma5gqhMGY_w-1
X-Mimecast-MFC-AGG-ID: WD0rXxV3MQ2Ma5gqhMGY_w_1753973689
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ae9cd38721aso105165666b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 07:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753973689; x=1754578489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrfdQfBwi1hWO79GIcUjuPsQVqZpwzL238pikFlNxhM=;
        b=AAtmtEJ9yG+Qs8MUfU4lIhDX80BIzIXFZukRlYg8bzDkBZtHtjhq0Izgf8wxL2TzjE
         qqUV2VT2Kl9PwWCqUcOQ8QhdxVsoS0nevPjAHW916ViESFtjPkJ+iicO3rxqN6GpeWB6
         YBNQXKMacMefT8Uvo0dsJNB49lV6v5WZLNUefREexMD2r8pkzhO5mv64CXn9jp2akUts
         6N9+bOeCXB6wG4Usqme2o9TVWTlbfM7kEqOWi1ir0/EGlHCGfWLSe9SsqgT9+ton7aG4
         nD9mQdrhEM31m2tplzy3tnD6ESMj6re0H3uOyyrziJioAEtQEGM65c1mRvlAMlwaPjTT
         7O0g==
X-Forwarded-Encrypted: i=1; AJvYcCVBi5YVBOS7ZB+MqJyZcwnfqJkHl1dg98iSN9jG+hDtXFK+91Z5/7oKZXd8Xan5lE1qv8Sn0xSWG36M3j2f@vger.kernel.org
X-Gm-Message-State: AOJu0YxGzd7yGR5Nh8/rjbTWjMsCyAZpQNClownpoHBBpCLKjMTbE4qR
	HAsPqTKq+sBXXs+AlpjoUR8HAXplDwUfjMY+4qZzAYOyplYelCSRxl7cvvNd5aHSvh2DIyKAd9P
	nlSzy7cIKXOUSvUnEvbNBX2eRZt+g17tnfXGgQpEI+vT6Yr1LRYMiztYV98o/lTMHCw==
X-Gm-Gg: ASbGncsz1lmShaLxtj6dJQQKperMARMyF5Iaba+mZqaSKuv69uUzUx1JFOr88lFddyW
	+zkXzJ1nPKOSsHLztHHFMatpBgP2GoeXbuK0JAUWB2T6yCESiVbRoyTq8aWHoY3OwYVXvKRcCeX
	AMLkVTp5u1XmdAS+jelz+/YsiKHAa2S2wx6+7kToOzpwxG+gU/w29S7ZEN5GAwf6WYMZB+NT8ak
	ph4hVB7ELunHRfXQK6jEnkTErVQmxgbLn7H80IMeiU+Dlb/y9x26M7Kid0ek0b6kKgyNg/Y+okb
	/xj3uU5BsjuUqBpxJCK8XTg6Z1fdKpC3kb8TiusvyMUG34OgblmeamuCHpQ=
X-Received: by 2002:a17:907:728c:b0:ae0:ded9:7f54 with SMTP id a640c23a62f3a-af8fd97fc2fmr965811866b.28.1753973689115;
        Thu, 31 Jul 2025 07:54:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ3bIkVHsPhtB7sHOYcgzjtiQWjSNXEBdItzzWHWGYY6piyQqHIyCNm3v0vApEyCqdPpdWZg==
X-Received: by 2002:a17:907:728c:b0:ae0:ded9:7f54 with SMTP id a640c23a62f3a-af8fd97fc2fmr965807266b.28.1753973688663;
        Thu, 31 Jul 2025 07:54:48 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a076409sm124698366b.12.2025.07.31.07.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 07:54:47 -0700 (PDT)
Date: Thu, 31 Jul 2025 16:54:46 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>, cem@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, david@fromorbit.com, ebiggers@kernel.org, hch@lst.de, 
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 26/29] xfs: fix scrub trace with null pointer in
 quotacheck
Message-ID: <s36etkudrevqb35gfscyfeibrwetxyrepuc2z2xg2bcgp7dzpb@hhaaawzg7vjq>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-26-9e5443af0e34@kernel.org>
 <20250729152839.GC2672049@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729152839.GC2672049@frogsfrogsfrogs>

On 2025-07-29 08:28:39, Darrick J. Wong wrote:
> On Mon, Jul 28, 2025 at 10:30:30PM +0200, Andrey Albershteyn wrote:
> > The quotacheck doesn't initialize sc->ip.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> 
> Looks good,
> Cc: <stable@vger.kernel.org> # v6.8
> Fixes: 21d7500929c8a0 ("xfs: improve dquot iteration for scrub")
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

@cem, could pick this one? Or if you want I can resend it separately
with tags

-- 
- Andrey


