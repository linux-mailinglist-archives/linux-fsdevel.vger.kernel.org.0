Return-Path: <linux-fsdevel+bounces-59427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAE8B389E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 20:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03BF3686C49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 18:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C308F2EA472;
	Wed, 27 Aug 2025 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbmztxSf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F47E2E283B
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756320909; cv=none; b=jFQuY9F1n4ytojeWYQKvPQH30UhXCxF9gY5fuWAL828HRNbe9EcbgmFKs5ywi7WfJ6bULq9jFEGhHo+UHWF9bRVkiasxEd4zpEkykYBlnNWhkwQ39L4ydTYg6s67n+nHKbTvezvH+IANb2t9TBmOQqGWuXeHj2hT1W3XfgVKmBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756320909; c=relaxed/simple;
	bh=ne728g33Ic89OdMPAENBxFjSizIUR3CqOaqTHDpBguk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjW9iZoH82z136QxUsa1ZP61mbEDB3ezmo0OiRubObifnCDoLDjeB7VLMASotZMBvaxh+LSCExL1VX8eSLwUdAfCSxSa4PMv9+rcjTe8AIbPlDJuZwEk7rzqz+RFoOJOjKYtqgRWqbdFhJAC9lxQ43Bo477ZYCrO78/gi455uiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WbmztxSf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756320906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eF3DTjEsZLVirufoG8QRMws1dk+QuLId/jBJE6DkJbg=;
	b=WbmztxSfdZE2yfRqWwNL6gNAqOpnwlvAHZuzXKCx7b94LCZlQJGVb6FSlkYtg8PGKAhoFi
	51lb2xg0vDtR1pVVB0YgwM4YwUginWDdrHAx1th4SXbqCnkLTm5OGBHMH83QCWqSFa5GQg
	Y0GGPnHDiWTehTIAkYaLD6Z8E0gkqFY=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-u_gDI1uCN5iWBEDHEyl1tw-1; Wed, 27 Aug 2025 14:55:03 -0400
X-MC-Unique: u_gDI1uCN5iWBEDHEyl1tw-1
X-Mimecast-MFC-AGG-ID: u_gDI1uCN5iWBEDHEyl1tw_1756320902
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ea4d2f503cso393565ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 11:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756320902; x=1756925702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eF3DTjEsZLVirufoG8QRMws1dk+QuLId/jBJE6DkJbg=;
        b=Jzg2fz+L6DipkIevxJgTOsrzTSmZ1iGoQlXfqtF4TUMMHa/LVYObMdJ9SPDdKcw5te
         ghXRY2IKlr+0hGSIALo1DI0lfkVrrLp3zeXnzsDMWr9ct+QGQCG1GRnt6m0Aw1f68ty7
         hB52wfj0+xfPELoVeRTDs5bklExSSkgPetnkqOrC6sKm6MUFemq8IuJ+ksQFWr1QOkqF
         NF61EhsniPTJcA3TlFguaPaWyza/11+b6tJse92Xj3jtqcQ6AkeZDZB+Kk4L5xBGYZfN
         5o5OA6Vg3q8Llm/qE650VRUfYKmgVljmbiLeu61rkseRj/o2hK2P/KwaXKnNljYPH9gH
         WCZA==
X-Forwarded-Encrypted: i=1; AJvYcCVtmO+4ak7xpmBTD1EuUEOVh+CLXaLtoDM2GOe1YDLHz+JnDhToYyr/funZgpsGqAANDP0j8vbWrl5os2M+@vger.kernel.org
X-Gm-Message-State: AOJu0YzDcMfpnj3598PRGEara/f16fgqzrkE8oWc6aux02ak/kmMMNIH
	AAmKrusxibz4//PVVV/NqZKyrdEexeNDGgVHoZaEFGQ4x5SfqR0il9aim4xVy+DGLd4gUG2St6k
	sVDGxD+AUrrIfVe6h/GLRuoJMkBc0GyKW/tQwE0U+dvrMTUaqUpPUMq7k196LDNMwM8Y=
X-Gm-Gg: ASbGncuveQAmA5+GAtwdcde++3V7VdUh5L2XX9gslbAF88TJ2SvV2iRVI//flWsNgqB
	EorUyEQhQi5njvTfFZXGXriKYgm26kX6hHPYYGxyayjv5zf1A3vrj56sCT1rhZNcxGyoS9KTdIi
	OlpjptYtaAlbQJ27pUaFO+0gBp0idUAY8Fi7kyhaiJtiZ1BKa43dVF+6MJHvhM48lHAJCFaqzmG
	27U8mbkD7mkl5IxI+ULBV4owHWAOacpc3E7qyLetz0b48pTqo7N7nFn4wIr7k04Vemyu6a1WsPA
	tvNlXRmY38IHxoT6j0p+qMlTC1zCkI7OcU0TUhnQO4c=
X-Received: by 2002:a05:6602:140f:b0:87c:469c:bcdf with SMTP id ca18e2360f4ac-886bd26223amr1074675639f.5.1756320902462;
        Wed, 27 Aug 2025 11:55:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcn4XXONhUn8JvBftE3ZsZrBNhr3WQ7ZVNO9SR8mW/jmt3C0qMFBX2Cm9qP6Uy+O7yYpbTWA==
X-Received: by 2002:a05:6602:140f:b0:87c:469c:bcdf with SMTP id ca18e2360f4ac-886bd26223amr1074674039f.5.1756320902025;
        Wed, 27 Aug 2025 11:55:02 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-886cf7a8c45sm722969439f.15.2025.08.27.11.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 11:55:00 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:54:58 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alex Mastro <amastro@fb.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>, Keith
 Busch <kbusch@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <kvm@vger.kernel.org>
Subject: Re: [PATCH v4] vfio/pci: print vfio-device syspath to fdinfo
Message-ID: <20250827125458.6bc70a1d.alex.williamson@redhat.com>
In-Reply-To: <20250804-show-fdinfo-v4-1-96b14c5691b3@fb.com>
References: <20250804-show-fdinfo-v4-1-96b14c5691b3@fb.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Aug 2025 12:44:31 -0700
Alex Mastro <amastro@fb.com> wrote:

> Print the PCI device syspath to a vfio device's fdinfo. This enables tools
> to query which device is associated with a given vfio device fd.
> 
> This results in output like below:
> 
> $ cat /proc/"$SOME_PID"/fdinfo/"$VFIO_FD" | grep vfio
> vfio-device-syspath: /sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/0000:e2:05.0/0000:e8:00.0
> 
> Signed-off-by: Alex Mastro <amastro@fb.com>
> ---
> Changes in v4:
> - Remove changes to vfio.h
> - Link to v3: https://lore.kernel.org/r/20250801-show-fdinfo-v3-1-165dfcab89b9@fb.com

Applied to vfio next branch for v6.18.  Thanks,

Alex


