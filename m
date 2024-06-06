Return-Path: <linux-fsdevel+bounces-21101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3032B8FE4E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 13:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42851F23D37
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 11:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F520195387;
	Thu,  6 Jun 2024 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Ywq89jY4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3FF194C88
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717672219; cv=none; b=dXXVsqIf4FoeHLenxiJP52OQMrSzKxxfsdgcbOSrcAB53iJcBsIYFZVi3KM00gGylivretBF4O7Vuu8EgKrucdlNewZUal7aOSKDgZon+2tn3VGPGWHLrT2gejSgs6nmrcZ9iXvyHOtjUOPExI12QZgqnGxRFDg9w8/7h2x0uwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717672219; c=relaxed/simple;
	bh=rKEbTCfYp0j2M89c2TXzm3ycbGwz3PSSgkyTb6IxAI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/AR5t3DUU4f8YphxtNSR+//PP+yKIt1iqyXblPknbnNvyuV1bhdPnC/sOP02Qchz2JCOXfivdAqAmiAxLQr6jRdLOStqOQZxtr4nXI5HqYCWDYFNZO+hSFJD1Qtl/BQIUlP+sQIG6q8FmQfdiQd3v1qhwR/XB0SA2/GVSPQW44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Ywq89jY4; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a68cd75b97dso85625266b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2024 04:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717672215; x=1718277015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rKEbTCfYp0j2M89c2TXzm3ycbGwz3PSSgkyTb6IxAI8=;
        b=Ywq89jY4ESan3QWUa19aIcqPxHPKLdpAukDsSsPWksHangGmAn67ZTKokh0QXssai6
         z8ZrJzYH0UoH9IoA8Vnovor65d5hBfON9BRwd21+pVsSJgtX5MBv1+vNT1wgnHZ2wRCP
         y9ztb45iGh0PgElbhCFvHz8gcOpdzVBQuPUUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717672215; x=1718277015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKEbTCfYp0j2M89c2TXzm3ycbGwz3PSSgkyTb6IxAI8=;
        b=hHgHwkMrASTnT1uhHAmvZrCIZzQSPDWLtJiF0ACMRt43ag6FXiFaNjsAv845xQkPuB
         Wp6FdD1JJuDSc5ZYYSZLO6T3FWdchb8N3GO1s9RRe8AWxW39f/nNk7PB6SGwqXd6hRYz
         opsmJDwtEYm8I3Y88OZNHaXoGEfbDnrv+jkLlLwDqDW5MOwpZw/1uLeuA8iohbms2ve6
         senzBd8tPZIaIhe1gL8e1GZnZxsHhJj98B7Pkr46NhMcnZcLOd4je7aW7BJzKpasncaL
         at1VhvEUUhtpQzSsqXsNs9zT9mEZLb1QJOvAxUHr0Ir2xgwF4YVJsVxTYwdmu92PZvr9
         CI8w==
X-Gm-Message-State: AOJu0YyTRVJjAYZ7Lj+3bmTL+Xy8kYMgrdg5rhknQkW/8j3R0t0AIDX/
	SdKRi2glqNHhB8w52XjL7JhBk5/uF5ATD8Faf5WFJZkfgJwImnYMAdb2JY62aDmjijYcWWskH+/
	CkbsHejfYnMbK53F7djpBJwpKnA3gJqoDlTCYqg==
X-Google-Smtp-Source: AGHT+IGm0e86tHnJ7ewyM+gpz++EnmWLvK7sCcAhY7kwEQzDofLD+hRf1Kki/LQoR67pw9uJmopjsOBrGPC3K9mep4M=
X-Received: by 2002:a17:906:5846:b0:a6c:7181:500d with SMTP id
 a640c23a62f3a-a6c7181530amr190193166b.45.1717672215456; Thu, 06 Jun 2024
 04:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000c27c85061828ca26@google.com>
In-Reply-To: <000000000000c27c85061828ca26@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 6 Jun 2024 13:10:04 +0200
Message-ID: <CAJfpegutqoJxR303yk_8pkvGidEztteGhTpk2uhf-oC4AXdZRA@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] WARNING in fuse_request_end
To: syzbot <syzbot+da4ed53f6a834e1bf57f@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
246014876d78

