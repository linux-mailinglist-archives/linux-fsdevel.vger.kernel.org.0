Return-Path: <linux-fsdevel+bounces-64356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10869BE2C93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 12:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6CC5818DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 10:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B5817A2EC;
	Thu, 16 Oct 2025 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEuxNlDF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5204732860D
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610003; cv=none; b=Jbst47OffMwevX07EiO8aoWXlcngNeZSGxmJdu9y4AiS45GxoZRloyjrFf7SCAxcTEv1OA7LoehK12BcPRUJ/fQ7itTmz7RFfifIZryEpRXMHjtigoD5CMN5npgVmze9EHjsudmBXMSOzGD0/kifWTjAphBWbKpzJUBk+LKwvZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610003; c=relaxed/simple;
	bh=Ja9OCsmngnUSE9D933GXE20U1SEDuEIJ/kJB/Ud5X8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tweuUbQnm6gqUO1RCsYoszLt8WDCCkQ3vtp9KoxeiizN6sDdITZ2yzxE3A5bThbcyAmvWUVfgvEyz/LIV379Y1fF1nmTJxcX+rNijFjFwycSRNyx4IMzkD+Oua7isIjs+BdsDp8jjZJMN4YBOkEd+xA6S45/O8T6EN7mWvcaqo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEuxNlDF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760610001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/lG9IkRu6rTULVmHXXnaYdq5MUjY3K7YFZ2k7C6bWjI=;
	b=YEuxNlDFjFq33W/NLqWKHXt5ghGe6gHbqABCS4PsDQeDicvbdPZyUSghuU0XFSKMOqnu4t
	j8ZbKjEsno8LH4HNpCoxTv0NY/83lxanHP4ezHloTJqqkqPZmOoOR1ZEQ3G0jM9RaRzFt5
	fZkW37njANvk9LcZb7H7iwsjis4Cayo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-Kk_L1j9KPt-PdtQJ_v1yig-1; Thu, 16 Oct 2025 06:19:59 -0400
X-MC-Unique: Kk_L1j9KPt-PdtQJ_v1yig-1
X-Mimecast-MFC-AGG-ID: Kk_L1j9KPt-PdtQJ_v1yig_1760609999
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28e538b5f23so8471505ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 03:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760609998; x=1761214798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lG9IkRu6rTULVmHXXnaYdq5MUjY3K7YFZ2k7C6bWjI=;
        b=c/umwAio1cHNCG3ZRnZb1JCiobIACPEWnYMjujInRSp5eYB69xRirZH/qXo27CZkTT
         fIIYKma7uIEEeh6lXEgNxrBBG5CfdhjtB/4bUIw9+B61y2Kq2KdfNMyeZXS6jwia4P90
         kOBSjGp/UkeAeOEz/mTWTccWvZE7WYD0coFuLCOQD8+CAsf1c50M5YZ3WRF2S5lcsLm/
         yth1LhtXJCvWQyx+DlIM0nKAZYKy4uCHPUkE9KRaDvMincMfNiw4VUpEaJwu1WCzX3pm
         vKph0Q231zHUDXy5Y3qnA8mm7Rk2N7PGg3UVNvBHa58Lj/DsI4OeN2DCWeSrUVU4O1Ut
         3YPg==
X-Forwarded-Encrypted: i=1; AJvYcCWpbNKbICzFn/sY82jz0ZtwhpE46QxLqfE32VFDCMKIp1ziZ8I6gJw4gKIoAbEKeDKewNYrT4Kw3LCzAxhz@vger.kernel.org
X-Gm-Message-State: AOJu0YyPbxtX0ln2bnCcTfMckjXOV+jabALSuym6kAat+5mbr5oBsvUR
	RRku+B0KSx66u4fnxWpIlwfqo+joOdsUe9KddmuNXkg8iKjNRT8h7gAEA8LmmC1IqlxrL/V2VRn
	j4f09OFZu7k7YSvz+9XtKfp1L08ykiVYcbKU0ut5iRxMH6Cze9zMsCHhTXMWbhYCT4zXH5SDimV
	/5yQ==
X-Gm-Gg: ASbGncs5onQboBAm04vlbH+CT0IZ3IYvGsC9PRd9J+47kFfHMCZELM0J8rTPzJt+rl0
	gvtbBXCIau5S2vkjrZHeBeP0JUMji6N6dMo0Hhqh2O4cB5SFw3zDw5uVVhvTg8pPT67NQsHMoJa
	SA/IxKthH9VHNiTnLEUjAzu9W9BW88qgCrc3DAQbYsAzqUispZ2JifVsRipxKwF0Kr++LP9z5S6
	ern9ZJqyRvf0nqvPwGmJ8PmjtscLi0TOFwN0+aTOoMb9bH/vKXBFDqXqeB/vifHpGf07Mlhl/+m
	LaL87ZUOp8mPWVCOEqpzUvRp2eNAb4uA1KhyljZzjlCZnWBr3rmUhSseazLARFHAjRwl5w==
X-Received: by 2002:a17:903:f85:b0:264:befb:829c with SMTP id d9443c01a7336-2902721634bmr337193895ad.9.1760609997635;
        Thu, 16 Oct 2025 03:19:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTlevuCwFZug23HK7ieK2PBYjuqcD3nAVQRBsGzWAIrpjkSn/kauHrjBi4EzPYnipAaY0fKQ==
X-Received: by 2002:a17:903:f85:b0:264:befb:829c with SMTP id d9443c01a7336-2902721634bmr337193655ad.9.1760609997255;
        Thu, 16 Oct 2025 03:19:57 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-290ad977cacsm15444725ad.105.2025.10.16.03.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:19:56 -0700 (PDT)
Date: Thu, 16 Oct 2025 19:19:51 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH rust-next v2 0/3] rust: miscdevice: add llseek support
Message-ID: <aPDGxz04OQgzRQqL@zeus>
References: <20251015040246.151141-1-ryasuoka@redhat.com>
 <2025101544-stopper-rifling-00e0@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025101544-stopper-rifling-00e0@gregkh>

On Wed, Oct 15, 2025 at 07:40:12AM +0200, Greg KH wrote:
> On Wed, Oct 15, 2025 at 01:02:40PM +0900, Ryosuke Yasuoka wrote:
> > Hi all,
> > 
> > This patch series add support for the llseek file operation to misc
> > devices written in Rust.
> 
> Cool, but what miscdevice driver needs llseek support?  Do you have a
> real user for this that we can see as well?

Currently no. Because lseek is one of fundamental functions for device
driver, I think it's valuable to add support. I believe we'll have real
users based on read, write, and this lseek support.

What do you think? Thank you for your comment.

Best regards,
Ryosuke

> thanks,
> 
> greg k-h
> 


