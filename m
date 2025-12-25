Return-Path: <linux-fsdevel+bounces-72090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C60CDD75D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 08:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B458B301C94A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 07:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780BB2FAC0E;
	Thu, 25 Dec 2025 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWTHX13l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F03D23AB98
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Dec 2025 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766648564; cv=none; b=QdBDMnK9DEI8NV1hC1G2nCChpnmCejkIBL3KyNlBD0+iyzcsOP4uRCyFVxSbRu4mmvCFIw7AbDnWgGhLaNgVXAEaP9ha4Zo5rPlk7LdxYaUsZ0xzVsgmwV6NntXFPkrM1TSqYgecD5tdr4CY8oTZMavCl7xTmesHansWcQIJPIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766648564; c=relaxed/simple;
	bh=M0HBizGnJzb/gmOYZt5opmUPJlGxJGhPSslaY2hoFsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJ5z8o07SF2fidx9qWLgPH77BrgURXZ4B0dEkO+NhMnCUkrpXh+PVcY7ThS6wlzTpkigKEHB220TRxsh8syj87DLiU+F//0+wVwjP5LC59IA1/nozfRpn9u25zTyc4r5pamwWN6wimuWs07f2LpabIpcQOAsfZfjEyD8McJ5cRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWTHX13l; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-597c83bb5c2so5132301e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 23:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766648561; x=1767253361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JH/dFfYCMIoHohy9S/Pr6wHtFCrjcb1T+U4b6DTL7nY=;
        b=cWTHX13lDz2NsBQNhxZhD6bZbNJqhPql4WOTYvXPkSkr53RMIexGj0m4y8zY6/xbJK
         0o5DuUQmzADNvAAEet5k3Glv77niFKfD+uTtVEZD5Xk7mDZi/l2E4GPwxrTim/LWIchF
         71wobBviW4pl90ZkjnCbGE1QgpKVj7EoHguj/zKhIYi6rotYvGTBJ/BEHCbMHRyMWwmM
         uwLHHhEhgoLC/Pq9L6KRb8qMjDY1F/AlGZqTfJUD6aEH3dtRD41QFqyz7qdNHjykYX/0
         WiAH2b9mnJrWCbUfFZJHhuIAlDlDc6ZvPG3YRKXnS9phtNUAzkSgOLPws/K2VAYkoUfT
         pjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766648561; x=1767253361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JH/dFfYCMIoHohy9S/Pr6wHtFCrjcb1T+U4b6DTL7nY=;
        b=oPLqjZdPsQ1t3rr6S93sdh6nOAuyG1iU5R0KYn36JGSRJqS2LK/nwyvDMDO6w50oNl
         5EPLhB5cuzijnqmNqe0hzrreXgiaJOIoN3kwMq7756er3uXHufORFXTNtOfLDKSatLqx
         bquFIzDN01fEGuv7lNhHnAoSCaqqiBZhIMED/dNAgvu7apb97l9b5qk2jT3rmKjQblMA
         s7y9tQIGbO2cW4hJrpGvMwJf9wwd7vyYvpj5O69zY/d5XbRRAFJ+5NUGbnGV5N4GC0C/
         t3yplm/BbdoYHlJ5balpnZGj8tFiQApcN7RGBgi8I5JmrZw5KtQVtvT9oXQayP4JH3So
         jdKA==
X-Forwarded-Encrypted: i=1; AJvYcCXJjDKMDzZ1FfV484nPqGJDrxCOB0UfRITJAY1MXV1NsVsp3QT8U4YF3q7zF/fcETcEpFaB5eDu/8isjhl6@vger.kernel.org
X-Gm-Message-State: AOJu0YzioJuIgHvypNXRmBmEEj/NpGqYNk4KYtP3nbgH3Aw7mOy9VfAy
	E8XcxK/wz0AjnKVvoZVO7BX0M24EtT4taastKJ2qohUGRKXnzwZTTs6k
X-Gm-Gg: AY/fxX7+h8tireZjBAJx0ka1ZxM77WaMk9KGtSSsTZPw0kKOLbTF9ZtIQD8XGxoWogj
	nrFxzX/xGBJw4DzKKeer6042nm+6k8UejM2erq2pHD18522p419IFmFivBrFm8yKI81C22tA8+y
	rRFfoG1G0aTEhJKn+YLRXFyU0G9Pt6sSCh1IvDTCOcDlTBnnvycOMQfho4ESe7HREbJkaPVOGGY
	9btBVicylIrFblz9X9TGAXHWwhjIGn8WXQJhmLZlLdRUePGO+zaaXfoGK6HPLO+Y6h/rDgxrWGf
	TDrfCQM0r28tdeqUmhBRM4y1130wafeC+I40nhGijiErb9Eq93DL5yAjtO32GUMSfMHED3kwjeX
	Xczhaz5FSqBMBceqwM8aH029iHVpcgnEKZdh1omvdTSD3pow0MkJcwfDEXDBdgdv6VNy8iO9gwr
	OEUzYPc+MU
X-Google-Smtp-Source: AGHT+IEKcQ/bl3YA5IJNQI8/HaSLN5j/Zlw0b0rjXnY2/Jimvt2pMMku62rHjm1957Sjg3wrPHsVJA==
X-Received: by 2002:a05:6512:39d0:b0:58b:8f:2cf3 with SMTP id 2adb3069b0e04-59a17d15b3dmr7614174e87.21.1766648561054;
        Wed, 24 Dec 2025 23:42:41 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-59a1861f4d9sm5535487e87.78.2025.12.24.23.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 23:42:40 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: bernd@bsbernd.com
Cc: bschubert@ddn.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/6] fuse: LOOKUP_HANDLE operation
Date: Thu, 25 Dec 2025 10:42:35 +0300
Message-ID: <20251225074235.1729172-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b59c5361-c800-4157-89e9-36fb3faaba50@bsbernd.com>
References: <b59c5361-c800-4157-89e9-36fb3faaba50@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bernd Schubert <bernd@bsbernd.com>:
> work on this during my x-mas holidays (feel free to ping from next week
> on), but please avoid posting about this in unrelated threads.

Here is ping.

-- 
Askar Safin

