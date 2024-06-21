Return-Path: <linux-fsdevel+bounces-22169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A49912F85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 23:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E09C1F24A19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 21:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BC417C224;
	Fri, 21 Jun 2024 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bbc40YNs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629C74A3F
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719005179; cv=none; b=Bss5+3xbzsxzKpqYCyS/8LKSNEaUChobzvCEjPnU57FDkiTSelh5WWACOIBHQTRbq3iMnV3gg25St4koCebf2obRZV7WwUOOXI1Kb6GWP68ya26zfG3Td9laFBh3V113l3TDP/OkKWuqhPWrDgA3ABvQlsG+jhtbybTu/4LKuyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719005179; c=relaxed/simple;
	bh=MoG5LOlPDEy0odETqyI2UZk2OgwVvJkIV2zODFlshVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxxDPChareLuHeVIjuYcSKR9cl1fstRO8XI7UzFpw2W8LufF55e5LnZ7Stn03Av/ff+gqDv3aHG9XlhrUntfmiiZfZ9wm5EJ/Eca1JCaXd8/KbF+1kvTSDs5dNli16mjqKN4cfN8phoYv2/T5bgZAtgYfF4k8D3mF08KPIYOkes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bbc40YNs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719005177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=thP0nEUDrtQW96/5jB0/Xvoruza3ct4JGkvDNzAWKaw=;
	b=Bbc40YNs34zdK7Gz6BVNiIGIhmHUs7ywpnKdFwjJC4iohbA5jPVXmN6yVQx218zLyYhLXO
	L8IQ0L8dH7iVpmiynzbZxKlTUM1TZU7WojXTPvNIVIZHE1sg6BkNHsuQ9VKf794oXt3dAy
	3LAdBWglLpS0Aa5gUyDJUxeiLybWRLI=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-6pOzscHpN5qNr4R_YOM7Kw-1; Fri, 21 Jun 2024 17:26:16 -0400
X-MC-Unique: 6pOzscHpN5qNr4R_YOM7Kw-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3d1ca308617so348793b6e.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 14:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719005175; x=1719609975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thP0nEUDrtQW96/5jB0/Xvoruza3ct4JGkvDNzAWKaw=;
        b=QgiC6kYiB5eTqCaJIlQx3uAdNfNGKy/HYTKACiAJ0N8FCcvt+f+b610qU+Ywtgn4fr
         jWeiqW5WCXQUthmrXQVyJVjmjueMuaTUEYUNpuL2jrifXAohslQnua6DTdb3U7Ui+iwB
         tlyXlvK00e9P6FQUlNGAw5cCO5vNEqaj1GbujMNILlAZOpjCzaMkSYuJhkbniJjq7ZPJ
         arGOg5pSDWYkzyb8vjRxaLuvpcxHzx7RAz81rQUTTBNiZPxaT4gdfnveQTcvJgaSSzgw
         mDrjb8AZ539U5zGu+B8GyOT2Oe4yZkJKQnKAm9569p3bH4zkFvY7r/LJ3XkW9WyVPg5h
         yuwg==
X-Forwarded-Encrypted: i=1; AJvYcCUX9lIvfQFvQJHeKyeDRxM7f2FlUEYcBf94ZGU+gj8fzu6ZrVAJbhDPFdyi+J+WPvOyBaPwntTnB0kqmBEwyCyEjdjJ/sMZmLYC1Ayx/g==
X-Gm-Message-State: AOJu0YxoHPqP35ZrH9c+Zsz7FlS0fQHLQoePEmi6fTignc1yJEn7MjQI
	C/44Qi0d4+MlGgwWsAuNuYk2QsCzS9SU6P1HfDx7DnqVdQfks2+zDSmB+I6nPP1K8gVQIrUmT1l
	yU8F/JVGpSVI6PkACX7FKzyaTLfc7NfZtbaoo9xvJwubEfCzcSpzIJCxw3iQ8zCg=
X-Received: by 2002:a05:6870:96a4:b0:259:8928:85ec with SMTP id 586e51a60fabf-25cf3c9e387mr51762fac.2.1719005175005;
        Fri, 21 Jun 2024 14:26:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKlfNdgfrg3d44ggCIG2pMpMdjiG1vA5US9y7a35Taet6dJbuCF3xZJpWG2QJBFSDX/uR1IQ==
X-Received: by 2002:a05:6870:96a4:b0:259:8928:85ec with SMTP id 586e51a60fabf-25cf3c9e387mr51736fac.2.1719005174490;
        Fri, 21 Jun 2024 14:26:14 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2b989aasm15017181cf.49.2024.06.21.14.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 14:26:14 -0700 (PDT)
Date: Fri, 21 Jun 2024 17:26:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Audra Mitchell <audra@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	aarcange@redhat.com, akpm@linux-foundation.org,
	rppt@linux.vnet.ibm.com, shli@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, raquini@redhat.com
Subject: Re: [PATCH v2 2/3] Update uffd-stress to handle EINVAL for unset
 config features
Message-ID: <ZnXv9Kc_Yt4j7YtW@x1n>
References: <20240621181224.3881179-1-audra@redhat.com>
 <20240621181224.3881179-2-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621181224.3881179-2-audra@redhat.com>

On Fri, Jun 21, 2024 at 02:12:23PM -0400, Audra Mitchell wrote:
> Now that we have updated userfaultfd_api to correctly return
> EIVAL when a feature is requested but not available, let's fix
> the uffd-stress test to only set the UFFD_FEATURE_WP_UNPOPULATED
> feature when the config is set. In addition, still run the test if
> the CONFIG_PTE_MARKER_UFFD_WP is not set, just dont use the corresponding
> UFFD_FEATURE_WP_UNPOPULATED feature.
> 
> Signed-off-by: Audra Mitchell <audra@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


