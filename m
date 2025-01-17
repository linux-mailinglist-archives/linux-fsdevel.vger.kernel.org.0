Return-Path: <linux-fsdevel+bounces-39494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70702A15251
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 16:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4131651B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 15:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A9A191F74;
	Fri, 17 Jan 2025 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dA3skjkt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67690188713
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737125995; cv=none; b=F6t2R+AOyyrBzxMd8pzKNdvaLb6C2PIMZjZ1REpas37J2oFJ5WBp0yAn22krs1ZtkcmLsdwme+6CWPopUNjJMo2xIIUF7XQRvSQQmN+B8tgkn1HJHhzsF9HtUfH14qFHaaOigGWi6102j0pni82lvZdEqas+yfKTc9pL+An7e30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737125995; c=relaxed/simple;
	bh=FYIdVyLJ1VEZanD40elISQhj8UBKvnUmQ14RDqI3Rcg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NscKcXuxu7onCaCOzWfX/gDxAvNrtSLg3XbDoIev4PSvt9fzF592VkA4RT33qn66ZbJd0yQ7AGmiADf48DsAbudsP6vPmq00jYKg5jkg0ohuSxtyIOJWXXSKbDqeDohpeTo/XWRErd3jz83FH1p0QIiDxNx910xiU18xh339/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dA3skjkt; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso1223818f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 06:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737125992; x=1737730792; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XoY2CmYqDhwCjr+LTaQT1CEx+jVsjk82eanBRDuR1qg=;
        b=dA3skjktSnO+ewKKOne+ZBopa1eS5wgGVcJKpt9Cb3xR+luFftABtf2wPU+VpwaHee
         IeUkxlNYzimWj202H6HiFJo4D0sgEw2Q/5YLCtprzNAgh5ucIROD7jtGNJ0XXY9IV5FK
         fgzDaBqg/ueKh4za5lgOHOs30D/MRLWViJQvDemnYuEBT6KZk3MG3kq7tMxaVnDTSi6k
         IQueHPh/rrdus/yQ+YmMhQbvl8jORP477NL0DrGDMIMf67OS/hHQqHDCa5EoiFjvntrp
         zKHyYS2OopY3HBtKcjTVbCHPfy1mSuhSdM85iUdiBDPxxDWLx03p0TQZM2lsIPRR9ZNe
         gcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737125992; x=1737730792;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XoY2CmYqDhwCjr+LTaQT1CEx+jVsjk82eanBRDuR1qg=;
        b=uFK16n+z28xIfgoqg/b5gvr/dIpxAI9lUSm3HZcmPSPiul0ZZCIo6D4EwN943v9Zae
         T8LGYaRY1Op2Cwg1DZmxrwi4uogfFUrDlD8Dq82OmMVSI5MTk+vpnxH5c4rPdU4C3pW8
         W/vj66LVu8aVqt7hVzQptL0Mlbion/hkdiC77GNM+MLVhrlGvWhS5afKKRDBTWNo/CRY
         KZVeUOTXYCwicb+DHgJorJlXDXA1T6dguU60M9QYQQZiUvYett6y+W1RqcvVKG9x+Z9w
         m6IGcZxRF4M7yjkb92PettwtiJy5LpodfxUFmImURIsvgtzAowe0inDGcy/9vZLxSu3a
         ZN0g==
X-Forwarded-Encrypted: i=1; AJvYcCWXiAekugTbhifgqZ8U/ED5jVFwS0tlVi1ygKIwgZrtaKi3kwL571K3N7VZYJzH9bZjb54yD9QKwunhdnbW@vger.kernel.org
X-Gm-Message-State: AOJu0YzT8PrhTKtlt8M4m2aqQMcAlmpzDchQ0cmd9WCIEcER9J+Y6J2V
	yVYdRyWSoHck23h9Z5oTB+ykSjYQwf2Jm2vdILaNtBazF5ahheOkFPmWaB2ZWzc=
X-Gm-Gg: ASbGncvOFqyxqCOSPnTIeE/+mkMi+bVyPVN26mgR1irpP5Bs4Hlz2NJUxb14YvVTBe8
	YLj25WdlYsMNqVlqebbwnEqNDQkD8Eusbx/e4TIApN17kQz0XjNY30NU3/JAqMI/pd9xTpxQkUc
	0PNaaU5oZaw+FEnXGEd9u7LHmmrKPlu8VJLlm1HkBkgVtPQvhrwobCZ1KszljocnPjKN/9mjny4
	n5ox5l4W1zi0x8U1nMs6L8euxf+u4ytWsOPXp1lcyESrsbTC1qDgk0pDURhp1krGoc2/g==
X-Google-Smtp-Source: AGHT+IEeRJ9cpKeNPyOpv6YqDFfsJM6JExhw0J3WkruNYdK28qTCi2QUozVixRXMXz9wRrk9NPLQtg==
X-Received: by 2002:a5d:6c6f:0:b0:38a:9ed4:9fff with SMTP id ffacd0b85a97d-38bf57c070bmr3026621f8f.51.1737125991738;
        Fri, 17 Jan 2025 06:59:51 -0800 (PST)
Received: from localhost (109-81-84-225.rct.o2.cz. [109.81.84.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3275556sm2751940f8f.72.2025.01.17.06.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 06:59:51 -0800 (PST)
Date: Fri, 17 Jan 2025 15:59:50 +0100
From: Michal Hocko <mhocko@suse.com>
To: lsf-pc@lists.linuxfoundation.org
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: REMINDER - LSF/MM/BPF: 2025: Call for Proposals
Message-ID: <Z4pwZkf3px21OVJm@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
this is a friendly reminder for LSF/MM/BPF Call for proposals - you can
find the original announcement here: https://lore.kernel.org/all/Z1wQcKKw14iei0Va@tiehlicka/T/#u.

Please also note you need to fill out the following Google form to
request attendance and suggest any topics for discussion:

          https://forms.gle/xXvQicSFeFKjayxB9

The deadline to do that is Feb 1st!

Please also note that we have decided that there will _not_ be virtual
attendance option this year. Nor we will be streaming sessions. We are
sorry if this is causing any inconvenience but we have concluded that
we will use our constrained budget more efficiently this way.

[1] https://lore.kernel.org/all/Z1wQcKKw14iei0Va@tiehlicka/T/#u
-- 
Michal Hocko
SUSE Labs

