Return-Path: <linux-fsdevel+bounces-43272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A9AA5034B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 16:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A241885ABC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A11F24DFF5;
	Wed,  5 Mar 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdlMdWuw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B0123372D
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187853; cv=none; b=fqgyoJGf6SlAK4mxsfXLUwpwklFz2nE0ujmNXzpgkrm0k4UdUUf0YIyppGO2mK1n39ajJ1RAUoD6FfjNUIWa15QVM9HW+5kNg/nz4k4htVP4Rh4c1+SiLWsOPy2Jb38DPwRhbphvyJ5eTddEU16DLgbjl8WWra/y6fll5aelPuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187853; c=relaxed/simple;
	bh=U88mUA2AiV0oSTqz9AQJ0s83frTddqYqFAsuM5dyHxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVef04q9rvPh9zk1Z2cqueEqxUqVh30Z9eZyfxzszdkUg5wHTmimqKwFhSH9GWTUIxu5x1O9uv7R2PkK4KK/c/jQwnDi0H/mOVCnPJwve6dWk8e2yvleqW15EXa4X1gvPBqHQdSCjG0S6vKvHC2eJM829+Zg8jG4mDHDoUoiWG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hdlMdWuw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741187850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9+E6suNuB7w2y11/teCBV4dS6wDPCblYduFz2wf7Y04=;
	b=hdlMdWuwysIH4c9qoxkSkSziNFTVbA3gy8uPzNAb68ckLlLuFCG3mBUt6Es287q7l7umKb
	Z9M494Ck6p+gtfEE9d4ZfL2RbPQAv+KBaDEuf7qbNbRsEwxitogY+YTMvr+UtZ3fsYtXZd
	W+RkhFzLzDDMWQyRn2kNmgAifbeBGvU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-_uC9_BxxNq6P1oPEIg8UPw-1; Wed, 05 Mar 2025 10:17:28 -0500
X-MC-Unique: _uC9_BxxNq6P1oPEIg8UPw-1
X-Mimecast-MFC-AGG-ID: _uC9_BxxNq6P1oPEIg8UPw_1741187847
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-abf75d77447so363917966b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Mar 2025 07:17:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741187847; x=1741792647;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+E6suNuB7w2y11/teCBV4dS6wDPCblYduFz2wf7Y04=;
        b=miIZKx7FKti4nE/YiYhx3Sx4Z6vq55bbEvssTqJWaEhco+diadInQF0mDhys/++ViA
         4c5NRp+/eJdYKzzZ2PZGCZ4C2co7J6CeQzohUMa+nSj3yzaDlDDEMhhW6soQRlCy2s0y
         BD5ckAhmZOszurs4SZPLYVKkhbu3oGC2eGa/8DDXBdz37OLBhoEuUbski50Wm2HWrmbl
         ua/jfhLyJ3lcXt5r1jj3gj+n2As8FE8fJqTnKTkxl+wqpFbKgzalhCDtLG/FlJQnSK0r
         snkaJavub7YOM2Lh4LGnzRae0pzCqxKjAj+eoIMRxcpCJs9jBz8Dxjo4B+NStTnsF486
         Id+Q==
X-Gm-Message-State: AOJu0YzS+/cTvdLJ6GexBK8YHLAiivLV3kIC2PEwd4C3Tq5r0IbrdWh0
	pIs7kYpPQ2p3fuEeort1L/T3et66meyB+gCs+eqFETUqSh5DacWwUsIaGfrNm9gpo5rBhBASdT1
	T1kAmzIlXbU/kC3JWCKfiPd50Ek9ap7vmM5rJrR1o+oj0esVqEGtHHO0A3f68XSu7a4zIkRY=
X-Gm-Gg: ASbGncsJeT9vXfy3O/fJkO8tUZ1i2godbzwqZDFD/kMH0iAA2D4gBbY84/Czfeapu4F
	fTFiy+TQz5Sun6rHMcNebkRtISsEiyFZ64Bua/SFg6YLrDZsH1EKb7iurFsWiazVP7y+7QxVSoz
	2aNkTZq4IWdc9zUTH0Qs8jN3kjw6MpjvODbQCq6GWn1PqekyZlqX9EigA12TUj0u1lg4VGI4XcC
	EQ4A6Nft8LogTHwOehKAVGlF9O3Ls04DuKsQfwSqSzQaPInRA29Q4EBm+mkF2m727hgbIvrc2vx
	sqzucUsxvsIEHmNpeQm3vyTR+AnDfeaznHXqrp3rMhFxKcXEN8TtPcxK2R433ueshMIgpujbrYK
	Bvgy5RDYwHP/5GKwYYLl9BQyXMPzq8UZfocpcr6sU2CAGFljgCRDk+v7fCLb3XGIb6A==
X-Received: by 2002:a17:906:7308:b0:abf:489b:5c77 with SMTP id a640c23a62f3a-ac20db67a33mr360277766b.31.1741187846700;
        Wed, 05 Mar 2025 07:17:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2UdpSO+BAyv6pANzZ4C+Pn+eivqmVtgAc0namHROyiSwyEeh/0OttHC5qQ82Uoe386r/u+g==
X-Received: by 2002:a17:906:7308:b0:abf:489b:5c77 with SMTP id a640c23a62f3a-ac20db67a33mr360273566b.31.1741187846338;
        Wed, 05 Mar 2025 07:17:26 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf3fab70e1sm908455466b.50.2025.03.05.07.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 07:17:25 -0800 (PST)
Message-ID: <1546760f-9cfa-4b72-a0c5-90d82c1624de@redhat.com>
Date: Wed, 5 Mar 2025 16:17:25 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vboxsf: Convert to writepages
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
References: <20241219225748.1436156-1-willy@infradead.org>
 <Z780TsepBGDVZOKL@casper.infradead.org>
 <Z8hk6qw1KTQQp_s8@casper.infradead.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Z8hk6qw1KTQQp_s8@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Matthew,

On 5-Mar-25 3:51 PM, Matthew Wilcox wrote:
> On Wed, Feb 26, 2025 at 03:33:34PM +0000, Matthew Wilcox wrote:
>> On Thu, Dec 19, 2024 at 10:57:46PM +0000, Matthew Wilcox (Oracle) wrote:
>>> If we add a migrate_folio operation, we can convert the writepage
>>> operation to writepages.  Further, this lets us optimise by using
>>> the same write handle for multiple folios.  The large folio support here
>>> is illusory; we would need to kmap each page in turn for proper support.
>>> But we do remove a few hidden calls to compound_head().
>>
>> ping
> 
> ping

Sorry I've been swamped with work so I've not gotten around to looking
into this and testing that it does not break things.

I'll try to prioritize this a bit but it might still be a while before
I get around to it.

Regards,

Hans


