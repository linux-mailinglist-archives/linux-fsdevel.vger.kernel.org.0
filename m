Return-Path: <linux-fsdevel+bounces-60018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6270B40E55
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 22:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B063AFBDF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 20:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF338350D42;
	Tue,  2 Sep 2025 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fOITXO3l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8280C30C629;
	Tue,  2 Sep 2025 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756843519; cv=none; b=qJAUTzVl6q1A/2QdlHJCVEjuKe/6FA1KC+NJrxUQm7Ozu4JqGTNYxFmts+QwEWgK3MmyxHSnD0E/XJQd/YAnmEsgavOLq1awRw+wHTH43zcMoof0IBMQrKZJ9aCbCmUQySgOyVP1OM6+/3cgDvuAb+zygkIDZSAQC31HNL7btRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756843519; c=relaxed/simple;
	bh=ykWOa2jXdfF/nhMoE/XhMQMlz2GrK9+COjBO/ieUrxE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=f4M/EoPLZQIVBvRWavLfNdtiX6WvcxKmDYpoM8apWALRihVnKO0OgP7L6qCcUFsWZ/BtMBdaJV9IIeMt1Am/V10rheIZC14NWZoUoJteUp2c94k6cL31BH3tUzzg9s8QI2pnY82TuhkxDeNJlMZkGTtO6I5XkFz/Zxm+jrZ/ldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fOITXO3l; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=BTJf8a3c8djKy/9Sijq7tylusCxaJef2zwGQf7+eDdg=; b=fOITXO3lE5266NU05BWGMpuW8o
	hv3scSW5HT66QL8/L4ofneKFefvsWlzNpi1smAf/275wSSLYavdI5L5XaL4fyEhsfs/RX+Umn5d8Q
	SyXKGSPpFLfTlAvErn4Ndr4AjTfAvNJfDhwUGa+WjKJ/vyXS0dUvtKiGvXKNQ8JP+/3yAP7MClhfK
	qGZX+u1Fa7EmpILdLO9KoHpH2DwYVt2xv124EBg73q/PIsVEd46lxBqp2alcuxHUOU2+k3vAq8Rxg
	HLvoz75nlAmvhFRGhWCN7Tis+NrZpm27UkU9ztipjQXGkkT06bKtndo4CCPvv/4K+S6SngeV7Qi7l
	+Ll19jHA==;
Received: from [50.53.25.54] (helo=ehlo.thunderbird.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utXFf-000000043p2-3AO9;
	Tue, 02 Sep 2025 20:05:12 +0000
Date: Tue, 02 Sep 2025 13:05:09 -0700
From: Randy Dunlap <rdunlap@infradead.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Ranganath V N <vnranganath.20@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
CC: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, brauner@kernel.org,
 djwong@kernel.org, corbet@lwn.net, pbonzini@redhat.com,
 laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH] Documentation: Fix spelling mistakes
User-Agent: K-9 Mail for Android
In-Reply-To: <2a1344d7-cbf4-4963-a774-6332aa440cd7@kernel.org>
References: <20250902193822.6349-1-vnranganath.20@gmail.com> <2a1344d7-cbf4-4963-a774-6332aa440cd7@kernel.org>
Message-ID: <A33D792E-4773-458B-ACF4-5E66B1FCB5AC@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 2, 2025 12:59:05 PM PDT, Krzysztof Kozlowski <krzk@kernel=2Eor=
g> wrote:
>On 02/09/2025 21:38, Ranganath V N wrote:
>> Corrected a few spelling mistakes to improve the readability=2E
>>=20
>> Signed-off-by: Ranganath V N <vnranganath=2E20@gmail=2Ecom>
>> ---
>>  Documentation/devicetree/bindings/submitting-patches=2Erst | 2 +-
>>  Documentation/filesystems/iomap/operations=2Erst           | 2 +-
>>  Documentation/virt/kvm/review-checklist=2Erst              | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/submitting-patches=2Erst=
 b/Documentation/devicetree/bindings/submitting-patches=2Erst
>> index 46d0b036c97e=2E=2E191085b0d5e8 100644
>> --- a/Documentation/devicetree/bindings/submitting-patches=2Erst
>> +++ b/Documentation/devicetree/bindings/submitting-patches=2Erst
>> @@ -66,7 +66,7 @@ I=2E For patch submitters
>>       any DTS patches, regardless whether using existing or new binding=
s, should
>>       be placed at the end of patchset to indicate no dependency of dri=
vers on
>>       the DTS=2E  DTS will be anyway applied through separate tree or b=
ranch, so
>> -     different order would indicate the serie is non-bisectable=2E
>> +     different order would indicate the series is non-bisectable=2E
>That's not entirely a spelling mistake
>https://en=2Ewiktionary=2Eorg/wiki/serie#English
>
>Best regards,
>Krzysztof
>

Obsolete=2E  Close enough for me=2E=20


~Randy

