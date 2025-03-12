Return-Path: <linux-fsdevel+bounces-43805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 446BDA5DEA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 15:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDED16CF4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 14:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DD024DFED;
	Wed, 12 Mar 2025 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFpeO10C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7B123E323
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788577; cv=none; b=OJHZpBvCDh0z6G6vUGG8nRPqIE7yIT12CO0lYTQGEj1GBCmDzaw13KPWXW80XIDkWOztSvBlOo8ROjT4nwgNYqkDYs/W0dXekoW9civS0In3gU9qbcm02gLnR068EIGcmEvffdFcns+eweUd7Afn1PGjQ0QkzAnhwIQiTzK7U0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788577; c=relaxed/simple;
	bh=WOtEqvsTAlWvvP5rpIOeUjc+MqZj+OxBToAOp2fiQkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PL5O4ja0rnfCvCnmy0QHb9YbCmPC4QbyYc8gYFmN0p/czZzTrlU/OVNjIdoRyd3HStq0HWQR/RZ4rl0HxGfNTryKJEF5HiQr055D3Mcf9wdSYglGEsj1v7A5F+hZQ5ZcyK15BmgSknQn25wFLA7jCy5dehCJ2+ijaA4lbqbdmX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aFpeO10C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741788574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rpJ4Bp2vaPkKMLBIs0XU/8MrkCeKduDmY2mvsnVWvGk=;
	b=aFpeO10CRyrPR66R2Jno3BROrfdi3v6VdRfrstN+uF6qhzZbkTKIo3VblcMT+anNNCrmMm
	fMlbYrWk2wh86sn/WbuhU96FhSQwMzeCwHBA1bWG88DbPmX9Km/ctt+teygdixnodSyHiV
	eDFX0fowzyqDRGkZrZNYpFXQCv72d5g=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-bb5nsvUZOQqX3Xyq-dUq9g-1; Wed, 12 Mar 2025 10:09:33 -0400
X-MC-Unique: bb5nsvUZOQqX3Xyq-dUq9g-1
X-Mimecast-MFC-AGG-ID: bb5nsvUZOQqX3Xyq-dUq9g_1741788572
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c53b4b0d69so1268257785a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 07:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741788572; x=1742393372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpJ4Bp2vaPkKMLBIs0XU/8MrkCeKduDmY2mvsnVWvGk=;
        b=DVmDMlsrKeWKqzXz1Omrw3cWmhzEoifuoO/dMPp6Qm/XrG7mCEHixz+QXtMw1R4XiV
         fjVADYOvaY24W5woEX3zagm6top72xAs2FA2oYjCzjM5gfL6Cqjo0zd57IaOrr8xsprs
         rpGV1r96bUcqcAEeSt5wrQJddjea5xUCS73H2XVQeC/f0qbrMZXnf5ERSYo2PuAzr8Ey
         p/uENvm+E4MtIiqEWdZZae8Z6i6tFJ7r7ETmifR7v4DK53HBvNr8jLYQREwDhyGpnzIn
         Swsr8hAgq0fy6BX3ynmfId0/Y3GdCHvD9Q4jkB/xSNNqoCX6pLAlfHI1bqPBoOV8ZFo+
         P2NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmn/A7WPzMKxZKga0zfFsBT01FhUnDWBeysGW/e2gBlTKwFQufWhU6qhZTHVlvO+Hp5tuM8A0v49AkUrlS@vger.kernel.org
X-Gm-Message-State: AOJu0YzHNQ/E8lO9lSyTeWJ+rUz7ESL6a61S+FZaqLgCuZtNg/uA9/ZC
	YrE9u+lGdjrsiLnmKwnHPDvbajNHjpSxEswisj/31hXVieJ40Aqu3Sd1K34ofVnmTnJC4R95BAF
	KRdGSWse+5hPqQUArFkRKx4jVWuVdfBs17AoEa2hPyzcGHPhnq/5fh35sT/LVkrU=
X-Gm-Gg: ASbGncuTqy66wvZInCzsO7qBCNGWuAjswuptYBDKUCISnf+zmNk+2FhzXBSEGG8Aywf
	ZuUvhxCh7Fjrz3084vxxxBgrtAhlQB5N2hfg7nlq/Mhq27U+Ke72wBJv81F3iTn8rxvlUTxnTmW
	S2UFYtpcwU0Alg4pI9PRtfkeRTAnDNlLLkRH6n1OjYWq+lPLSqL3VU07QVGiHey2eHoD1JwIRiP
	vZ+O7W3NiUYkhtxniXyRKBG/UUtaFPU8iYs7+dDBg9cND9tfdew2hyBYWAMS5NQnOWXHo3TiUP6
	UjcXbF8=
X-Received: by 2002:a05:620a:1b85:b0:7c5:4b24:468d with SMTP id af79cd13be357-7c54b244796mr1835005685a.2.1741788572687;
        Wed, 12 Mar 2025 07:09:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZVAVnFr8TuudXs0D2kTM0FEywRnFo1M8MBCogN3k6/Xg3Qw7mBw/qIldth+aY3HnE9WFX8Q==
X-Received: by 2002:a05:620a:1b85:b0:7c5:4b24:468d with SMTP id af79cd13be357-7c54b244796mr1835003585a.2.1741788572459;
        Wed, 12 Mar 2025 07:09:32 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c53c07b645sm727548385a.77.2025.03.12.07.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 07:09:31 -0700 (PDT)
Date: Wed, 12 Mar 2025 10:09:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Jinjiang Tu <tujinjiang@huawei.com>
Cc: jimsiak <jimsiak@cslab.ece.ntua.gr>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	linux-mm@kvack.org, wangkefeng.wang@huawei.com
Subject: Re: Using userfaultfd with KVM's async page fault handling causes
 processes to hung waiting for mmap_lock to be released
Message-ID: <Z9GVmeHJSftfQPPF@x1.local>
References: <79375b71-db2e-3e66-346b-254c90d915e2@cslab.ece.ntua.gr>
 <20250307072133.3522652-1-tujinjiang@huawei.com>
 <46ac83f7-d3e0-b667-7352-d853938c9fc9@huawei.com>
 <dee238e365f3727ab16d6685e186c53c@cslab.ece.ntua.gr>
 <Z8t2Np8fOM9jWmuu@x1.local>
 <bb6eb768-2e3b-0419-6a7d-9ed9165a2024@huawei.com>
 <Z880ejmfqjY1cuX7@x1.local>
 <bb6bba1d-fabe-cc14-2521-ffbf2e31ac63@huawei.com>
 <20a6b1c1-389e-b57a-7a5c-d1b0a7185412@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20a6b1c1-389e-b57a-7a5c-d1b0a7185412@huawei.com>

On Wed, Mar 12, 2025 at 05:18:26PM +0800, Jinjiang Tu wrote:
> Since this patch works, could you please send a formal patch to maillist?

Will do it later today, thanks.

-- 
Peter Xu


