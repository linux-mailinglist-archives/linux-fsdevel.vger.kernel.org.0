Return-Path: <linux-fsdevel+bounces-43892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD144A5F24C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 12:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC5EF7AA810
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 11:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35912661BF;
	Thu, 13 Mar 2025 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Goipk6yy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640F1265CAB
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865176; cv=none; b=py5b6Lt/5XU8JAy3PPQuYvwy8V2Fazu4/FZOHnmLKSseN293MC+47NWzU+tB76/mkJRAs0Dl1lic+OnW6YFPbb/XIiRhq0s0GlWp1fqk6kZngF7G9PU1Sr/iD4cbupmAv5qdcgefOK/uoX7U0qJ3mAtPeo7DPwBHwdaODQQO8gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865176; c=relaxed/simple;
	bh=j8JKeL3My3p380xaKx7CR7AkatM+RkoyVjF5AKF9V/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XROcXUtTj7585UBoq4WbxfIVOiwC6ybXRRb7Xj4amMa/BcTbksLdEi3gKfUh0WJrZ+LyDyRyccC50lRVWGjLGxMVzgFvn7wLO8XpIUhEIb1KRBeFW+yYURCc/IgAmw2pwX4hBV2mtJN8FllSixkesViub910Tt0M0hp9PFjbNr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Goipk6yy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741865173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=haq21k8jWN6ck+QB/yq8TbL/zWBVpjmfQO2fprJtAqs=;
	b=Goipk6yyCBvyiEucUCgDLtQrHtHhHffFpE32KhbNmJHjRGPLPQpMPbfPW0EGjDVbKnGO5n
	guX4SVakDVNYlN6n1fPcJbHuh72z/B7J2keW1o6pNaEziMrbaoO7Cvc02sR2hepvXt2E84
	pQGvKLB5zwSo5eqcdlX+Ymlw7QsgAzs=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-ty1ENkddNs-HFsD6oyme7g-1; Thu, 13 Mar 2025 07:26:12 -0400
X-MC-Unique: ty1ENkddNs-HFsD6oyme7g-1
X-Mimecast-MFC-AGG-ID: ty1ENkddNs-HFsD6oyme7g_1741865171
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-86d33b8ead3so195376241.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 04:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741865171; x=1742469971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haq21k8jWN6ck+QB/yq8TbL/zWBVpjmfQO2fprJtAqs=;
        b=JLvLtUV9Vo31r3sjVJ7HDMcrqKzVFMOD2aqhwNj9evILm0qdd5LeDPsn/WRcUQ2XVg
         IgeDsmP5mcoPjiLG7u9WxwfCDES9KkR5CcPmw4WQToDFtwTa4mYlTD+g/HmKy+o2/m5B
         8dY786/c+SmzU0FY0xhcCxxq8SE5+/k6eZ1xxd4i/9fIJbRenElxKQFZlxr5aCP6MorI
         zgjm49QHCdfb2g1H/S2VlpZOEzB2hP3SCpday+eGrBjDGqL6F7vNPnd/wzwqqj4iUvRK
         yFY0vk5X6obIKhtLiLn+O2Jf8XVzO0InmqFWEkDNEduJ/kVqUFtcDx6OV/qMa7BOOViw
         EHBg==
X-Forwarded-Encrypted: i=1; AJvYcCVseykEerLaiaj8B5AeU5KuIREA9ndRg0ROH/V69dlVCI2xX1JixUuIZPRy77foLDRlgAbF4Ls8liB8UO7A@vger.kernel.org
X-Gm-Message-State: AOJu0YyN8+kbA5UTC5tgklL3JngmFMxA5RDWdtP2STayxL5SzA306XwW
	QGLl92jXNHduhTQAoX5p52a/WcRWay365GEcei1RZYa1VFdrj7R1k/bBK1++dwEsTHwhDHRBvcc
	CkmjvEyZqtlukzKtTxGmwrWsiS+/PraT/G31QL2e48+TP8hIbMlb+sAGNfYemRe8IqulIGTmQ6w
	8Ci2m7+x/e1/oHArHfH+vSA/DYltN2QqOf4sBAsg==
X-Gm-Gg: ASbGncsJY1rHSeliYYua5YW91VTbl/7H3PaDqkFKSWgb2cK1G9qoyH8kiNwAAp3SG3U
	pjB6fC0nL/hocH/YuBTMmWWeVU0gI7qMHLYn3+ejvytLWy9NvJHGls3prOSvDo/L6/xW3bLa2
X-Received: by 2002:a05:6102:8001:b0:4bb:e8c5:b149 with SMTP id ada2fe7eead31-4c30a5ab186mr20926955137.7.1741865171663;
        Thu, 13 Mar 2025 04:26:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5cD6PF7kl5NUY7q/OW1oKX5tNdN8eFO7rQ/PRbWr3pjIaSRJ9butzW+C+5ydIiGErfk+O9f+OrAd/60RAi1M=
X-Received: by 2002:a05:6102:8001:b0:4bb:e8c5:b149 with SMTP id
 ada2fe7eead31-4c30a5ab186mr20926938137.7.1741865171411; Thu, 13 Mar 2025
 04:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1243044.1741776431@warthog.procyon.org.uk> <458de992be8760c387f7a4e55a1e42a021090a02.camel@ibm.com>
 <1330415.1741856450@warthog.procyon.org.uk>
In-Reply-To: <1330415.1741856450@warthog.procyon.org.uk>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 13 Mar 2025 13:26:00 +0200
X-Gm-Features: AQ5f1Jo_X07BVCwtYl8dAOwfTVb-Lg71an6NgYoZsp8YoSb8JBQQYJu-cs0jBDU
Message-ID: <CAO8a2ShNtAGnaHpf8vj_vqgkw4=020cLn8+wQ9ovOO_5zDBK7g@mail.gmail.com>
Subject: Re: [PATCH] ceph: Fix incorrect flush end position calculation
To: David Howells <dhowells@redhat.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>, 
	"brauner@kernel.org" <brauner@kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm sure @Ilya Dryomov will pick this up, this doesn't look urgent.

On Thu, Mar 13, 2025 at 11:00=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> Shall I ask Christian to stick this in the vfs tree?  Or did you want to =
take
> it through the ceph tree?
>
> David
>


