Return-Path: <linux-fsdevel+bounces-46319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF13A86E26
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 18:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5F317CF20
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34361FF1B5;
	Sat, 12 Apr 2025 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abaBpV7J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5985F5BAF0
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Apr 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744475853; cv=none; b=GYhcQ7en6N8dDZmAlCHoL/AmGw4kP6hrdoOH4AC/K3Gf0olj3O6ENUbPblqQbDxqkp0LcCBkOD5B5KBkfP5T3lfVnYzcRM4fB+D7lXGSAW5IF39HIeOWkn3PcrQdMl3QHeb45E3AepHdSAv+emaJ7ph9jW7aGIFN5xBIjlUe3tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744475853; c=relaxed/simple;
	bh=3nlQeqLpakx9VbjVGGaVN/AwOVYMXPCNfTYZtnneuv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohUqdSrUmtWi/gZIDyyEDjFBfDvlOL5Mm9DRGkFd1W2D1lF+ZXDgW3xUhoaViKsmjDIDFWJmwTiimyvo4kBKisQA215JJSLFR72yaqkdhdl4sLfWN2MecxTIciEk596rBLHMaK2kQ+aMErILFspw37bYQ4wkOkxQRv7Rc46X0Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=abaBpV7J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744475850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3fiFsru6LnJQq9k1qZHmlYdUChXvApej+AwnAQ3uLE=;
	b=abaBpV7JPRwVTf2QqGPNcLm1RtEi+ptRoy7trLUtn6jKP0Rrhq6Y2zq5g5hsX+ssvvesfD
	ItG33TloUqJDTxK8UGjrdwums+O4ElaWp2MCkjBxYZZF1b4qHyNbxewaZE3dXpwNyTSWJr
	eD46/ZjzlWzQs6abtDOnqoAksiDbmdw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-o2SM7aUFPI-83D2Gx8vugQ-1; Sat, 12 Apr 2025 12:37:28 -0400
X-MC-Unique: o2SM7aUFPI-83D2Gx8vugQ-1
X-Mimecast-MFC-AGG-ID: o2SM7aUFPI-83D2Gx8vugQ_1744475847
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22650077995so42384285ad.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Apr 2025 09:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744475847; x=1745080647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3fiFsru6LnJQq9k1qZHmlYdUChXvApej+AwnAQ3uLE=;
        b=VShIWOSJjY10cbUBSYAr2pgRR+MEc1eNXLACHr6rwedcTCULoTMMjd2t4Q+SJjQeH8
         TzVGz+EwfP7sTptflqymRV8wSxw9gvER7Rbj0E9cmk3bj9CDC4kJUeqLPv+L2zkTEId9
         t+xKwFqTh9qF719WgrFLSfbZO+OnobzvylRuXo5QoLbuqDNuhWb5jrnjmuTJbCwLhHYm
         kEaWHu8mUR+GnHSqX0QJdsnDgFF8C34vsCemlIN3qIav1rbquzq3KbequSGDs9vakP5S
         cjVAfbSLlOTFASPGBgjYcv6ph1cv/Z/ElhMhO2bjHBQCqBkFkLX3eyRUrR9qSCAK+iZr
         eEdg==
X-Forwarded-Encrypted: i=1; AJvYcCX4Du7UAOaeladfJpHNECUWdVPqoGj+pbi5v4IFtS5LhzoBunIiJngesfTMMxAFW/eTvR4iKVxDX4hVJqQ2@vger.kernel.org
X-Gm-Message-State: AOJu0YzBxhNhgAfViNnoQSKM9/Vg0liHS7eKESonw2dtQAYPjSOsX7zt
	YbZjf4LTlM4HOJ4DX6sWwpFCNzmQ4ZQ+97z95qB/jlSA8SD1fOyRjTtN3x1OUzMBFgupTMinncq
	unJwdvx23rfQHiEC0AND6ruwNMlynoDuglvFnbkR5eagejN28x+XUYMIRfkbLsr0Le/tc6a+Skr
	QIAw7HRD8qMXma3lz0u/ZFZfcxNOyhOK8vPMxvQA==
X-Gm-Gg: ASbGncuIZdWKYT27OBrcQ/Qe8Z5yo4vUxqCZpF6IS1JmmsEP10VX44z9nWudAOKKnr+
	QUQlJS4zpX2LGV6zTgXAq2wX39EC7w1FEmsvpCZOKi7/GaInkexuh5E8LCZksvJsHC6Y=
X-Received: by 2002:a17:903:17c5:b0:223:5ca8:5ecb with SMTP id d9443c01a7336-22bea4efaaemr91129655ad.42.1744475846938;
        Sat, 12 Apr 2025 09:37:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7sLLGDrtrxmDABKermY+/WFSctIXR5dmHRBwVPDD2cHAaEfr8X4dND2BPeABs3RlvZSRMNQ6ofK7p0cF8CSo=
X-Received: by 2002:a17:903:17c5:b0:223:5ca8:5ecb with SMTP id
 d9443c01a7336-22bea4efaaemr91129475ad.42.1744475846684; Sat, 12 Apr 2025
 09:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411173848.3755912-1-agruenba@redhat.com> <c9014d1e-c569-4a7a-aa68-d7c32e51d436@I-love.SAKURA.ne.jp>
In-Reply-To: <c9014d1e-c569-4a7a-aa68-d7c32e51d436@I-love.SAKURA.ne.jp>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sat, 12 Apr 2025 18:37:15 +0200
X-Gm-Features: ATxdqUEc6bK4RDS8nTPgD4dEmZc4tgzp1L5AosoT3RAQjOcAirWwydpqqoRpyIw
Message-ID: <CAHc6FU7XDXCE--4vtH+q94NBZK-ScYSLTmeY4+J9T9YH7BtR9Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Fix false warning in inode_to_wb
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: cgroups@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Rafael Aquini <aquini@redhat.com>, gfs2@lists.linux.dev, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 4:21=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Please add
>
>   Reported-by: syzbot+e14d6cd6ec241f507ba7@syzkaller.appspotmail.com
>   Closes: https://syzkaller.appspot.com/bug?extid=3De14d6cd6ec241f507ba7
>
> to both patches.

I'm quite reluctant to acknowledge syzbot for this. The bug has been
reported several times by several people, long before syzbot.

> Also,
>
>   -static inline struct bdi_writeback *inode_to_wb(const struct inode *in=
ode)
>   +static inline struct bdi_writeback *inode_to_wb(struct inode *inode)
>
> change is not needed.

Ah, not anymore, indeed.

Thanks,
Andreas


