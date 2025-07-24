Return-Path: <linux-fsdevel+bounces-55947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D182B10D76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 16:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D81B041D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 14:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A178E2E267C;
	Thu, 24 Jul 2025 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBN0WxQK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DAC2DCF4D
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753366923; cv=none; b=KgBHsz2Km56TIL2oiukAjbzw5E4kzEaU+KxM0R1uLKlou4a7Mfdf86HKTPXoeCc1QrYPVtOcn2hYS++20Mw87DBoBoiczz/1SRKYMj2xgJG6sYKPX+FoQh+2dDMuL/dKXSOWvmj+Z7Icm2XZCRmCK3oJDNW6cuIhzaAx0FiJtfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753366923; c=relaxed/simple;
	bh=AgujDzSzkSW48YkKuO+1w6otcc46DgHKEp/ur4Fxwnk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Xzkvca+K0iTVxgOZyy6QI5kU7aTQ8bmRSF5ACFlbJsl9yJ81GF+X6PlnatvMeRPFp9mtNIsgVWeYvad4CDgcOimNRScuWTqk/ALuQPs/IuIuqTX0/aeygnwfO4FijLOfkyBftiUD/se3CREgs3JIBOMhE9Hq5OielZU5AT9El18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UBN0WxQK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753366919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VcRD4QEBKh/L+nEz4MQhKnQ14f7S6wCwdSp9kNcBTwU=;
	b=UBN0WxQKrEspcw7/9jm/WWPB7mDBtf+tYwdh9cnv+n2ykfZQgnO275uz9kgk16Q3GGsHjU
	xDAw2aBj6aJkG8F2cdRAGwtVUeBGnY70DEwoZwXwrn3glbbRZHPaMAjlJeaVRxJ2xlewDY
	GUNiJY5flg8LUl0sWbFdwsN20dl7bdY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-GVlGHWIGNcGH0m574v4Fjg-1; Thu,
 24 Jul 2025 10:21:55 -0400
X-MC-Unique: GVlGHWIGNcGH0m574v4Fjg-1
X-Mimecast-MFC-AGG-ID: GVlGHWIGNcGH0m574v4Fjg_1753366914
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFCBA180034C;
	Thu, 24 Jul 2025 14:21:54 +0000 (UTC)
Received: from [10.22.80.24] (unknown [10.22.80.24])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 663431956096;
	Thu, 24 Jul 2025 14:21:53 +0000 (UTC)
Date: Thu, 24 Jul 2025 16:21:47 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
    syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Subject: Re: [PATCH] hpfs: add checks for ea addresses
In-Reply-To: <20250721224228.nzt7l7knum5hupgl@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
Message-ID: <9ca81125-1c7b-ddaf-09ea-638bc5712632@redhat.com>
References: <20250720142218.145320-1-apokusinski01@gmail.com> <784a100e-c848-3a9c-74ef-439fa12df53c@redhat.com> <20250721224228.nzt7l7knum5hupgl@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On Tue, 22 Jul 2025, Antoni Pokusinski wrote:

> > If you get a KASAN warning when using "check=normal" or "check=strict", 
> > report it and I will fix it; with "check=none" it is not supposed to work.
> > 
> > Mikulas
> > 
> 
> I'm just wondering what should be the expected kernel behaviour in the situation where
> "check=none" and the "ea_offs", "acl_size_s", "ea_size_s" fields of fnode are corrupt?
> If we assume that in such case running into some undefined behavior (which is accessing
> an unknown memory area) is alright, then the code does not need any changes.
> But if we'd like to prevent it, then I think we should always check the extended
> attribute address regardless of the "check" parameter, as demonstrated
> in the patch.
> 
> Kind regards,
> Antoni

There is a trade-off between speed and resiliency. If the user wants 
maximum speed and uses the filesystem only on trusted input, he can choose 
"check=none". If the user wants less performance and uses the filesystem 
on untrusted input, he can select "check=normal" (the default). If the 
user is modifying the code and wants maximum safeguards, he should select 
"check=strict" (that will degrade performance significantly, but it will 
stop the filesystem as soon as possible if something goes wrong).

I think there is no need to add some middle ground where "check=none" 
would check some structures and won't check others.

Mikulas


