Return-Path: <linux-fsdevel+bounces-60909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82077B52CE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41381C84FD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 09:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6B92E7167;
	Thu, 11 Sep 2025 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5wW6v4L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769CC2DF6E9
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582250; cv=none; b=ak3Y9V4SShQkEpSjcT5Byj8NS6MDprFtJHRKXyrSNwY+GGUgqWPY7AC39hSGQIjtXPhbQwMY0SGJraqendZAmx+cBo+LDIC2osfCVyUqR3dUgSLCvi4QmrJ/kZQi1cMzjHvMWVBFqdO89neC7DzKiuZpsCQHxmQD5nVVkmtyxxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582250; c=relaxed/simple;
	bh=nRopOZdLmoabNyUraQZ8tWhkKnKT00UAZalz8gNlCrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JY6eFp+bIqf5LgedmVVtBGU+sivZ6Nm5V0RYXEM3OQwZyBxhsaFT5uXopiVoywtryq18uxDnG3HXhM2jQC1HkT+zW3LWJOsFg3sYTtjdhZzNhGn4JX5MbmqP4b3eB1d+D4EyvkDd5a3Gt1XTcwyd9OqlIp3F/VN359NVxGncNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5wW6v4L; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4c738ee2fbso461082a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 02:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757582249; x=1758187049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbW2IpP4iJhEkSOGqFGCsK7hlxWafH505HiZGCidKuM=;
        b=H5wW6v4Ld7Ynys29TQDzmqVTzS/s/pNEIURnQJHajBOe97UPZ+hHsE17C4QNa2dpid
         QyP2Oa0Oro/rvtZoqTa1KfKlzhvez5Od1gDZzc7lDBUE1/XLQvdJxJ4PiAux1Jid/xpH
         Dca85sF1yEUE8OphXktcpXtDRYUeRfaPK41iNf3ulsl9ivGUHCZtjZxJfrDWeeHT1BxI
         1FGErLGX7fwBmzQ3sFuptl0BPnfJOdcWvnB23puxOmVG7Oo/PUKG5WiBKuBQc2sQ7jrW
         3MXk4EVj5M/LGZsvrW7iiF5/U0O7lAp1cP/gGnLKHHyOWKohL6ligV4vTMk0fIwIpoUb
         wsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757582249; x=1758187049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbW2IpP4iJhEkSOGqFGCsK7hlxWafH505HiZGCidKuM=;
        b=C8wC8YpEMWbIAvNtwAGhqHKVuBbEaerNqlN48OHPi0NYChtDtEytbkl64V7j1/9BvJ
         IXSJHJ7d0tGDMjkTLc/QkLHizGDCCYZ/RJWIbb0ftAvzep3U6CgyhCClcOa209gQrsKZ
         EuzVs2X4AbZKtYSZ/mS00ZVWbBVlB8gbxii/+ZB/qmByxFquPOgf7ojkS+xQ8I8HJLQz
         CgJ6goCanfSwbm8HYakvarmvSlt3oTvQ6hLHkmSfbtgaRGYLN5u6067uuK1H4XHTUCl1
         B2LRbpayraEtRgDScMeyNR81h4uXADF3X7MYOvu6PZJ4A5TBzTsckmWi2C3B7aY405y+
         BMAw==
X-Forwarded-Encrypted: i=1; AJvYcCWCS+th2QhSaDaZofH6iWHAewNvMtliJmUFDnwoiSQYtyz/XXAPuQ/vxwzPlEDHfSkcZvwuKsSx0tMzNZEm@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd45tTI+BMTjUNVO82LZh1rxd+SO9zEVzS+GMicmziFStlZzK8
	aB4M6bK2jqLJMtjPzOdWbuSDkkf7/WjxzdGNQ8cFiR4L8JokQ8YIY8eQ
X-Gm-Gg: ASbGncvEtmM0SXOrtZtfdntqmkIL9A6xj5+MuVpnZNxcQMeqQPsgYIv5tmh7KsnZEM1
	XDgtxDNaQgUE3xwOQWgha/A64cAw3Aw5L8rgmihh+Wlyup92dX79JAVQWjwkaHZGVfLecrywvDY
	Q5A50qBKMChge2sF3ugDQE7jIUynT6/b8SFqYYNyEIUhwwXEUy6SS+0qP0zxmSzFHZaoartwdwz
	tdcAiCuobPxKVXHnl2YT9kkrj88Hj+kdm457HF4tLfiYPx1Mkns43Cv+4lJjCcMtmgb3YglG+gz
	vs7YdXiVb0V0joqT/8WmlQWNP0UF0gsmJfwK5j87W19wiphTwCXcB1ezjNzio36Dp4RxrvrLKla
	PmWp+N58wyKdL1xXqzpWKPjTaCI6UU7z1NnYiP2RB0W5n
X-Google-Smtp-Source: AGHT+IGdNYE+dmhUuvc/wFgrZNzzmv3OTe5tjvhzE/L0vEbZy87456Q+ZpSrek0dlXJ+tGug6w7OBg==
X-Received: by 2002:a17:90b:1dc1:b0:32b:5c13:868d with SMTP id 98e67ed59e1d1-32d43ef6d63mr22709012a91.1.1757582248622;
        Thu, 11 Sep 2025 02:17:28 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd632377fsm1942431a91.23.2025.09.11.02.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 02:17:28 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: hch@infradead.org
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	yi.zhang@huawei.com
Subject: Re: [PATCH v3 0/4] allow partial folio write with iomap_folio_state
Date: Thu, 11 Sep 2025 17:17:26 +0800
Message-ID: <20250911091726.1774681-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aK20jalLkbKedAz8@infradead.org>
References: <aK20jalLkbKedAz8@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 Aug 2025 06:20:13 -0700, Christoph Hellwig wrote:
> On Mon, Aug 26, 2025 at 07:39:21PM +0800, Jinliang Zheng wrote:
> > Actually, I discovered this while reading (and studying) the code for large
> > folios.
> > 
> > Given that short-writes are inherently unusual, I don't think this patchset
> > will significantly improve performance in hot paths. It might help in scenarios
> > with frequent memory hardware errors, but unfortunately, I haven't built a
> > test scenario like that.
> > 
> > I'm posting this patchset just because I think we can do better in exception
> > handling: if we can reduce unnecessary copying, why not?
> 
> I'm always interested in the motivation, especially for something
> adding more code or doing large changes.  If it actually improves
> performance it's much easier to argue for.  If it doesn't that doesn't
> mean the patch is bad, but it needs to have other upsides.  I'll take
> another close look, but please also add your motivation to the cover
> letter and commit log for the next round.

Okay, I'll try my best to clarify the motivation in my future patches.

Also, have you found any issues with this patchset in the past two weeks? If so,
please let me know. And I'd be happy to improve it.

Alternatively, would you mind accepting this patchset? :)

thanks,
Jinliang Zheng. ;)

