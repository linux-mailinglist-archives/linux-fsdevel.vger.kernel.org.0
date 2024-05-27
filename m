Return-Path: <linux-fsdevel+bounces-20238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFFA8D0231
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 15:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9362852D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 13:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C7415EFDF;
	Mon, 27 May 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CEWDhMIg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4F615DBC7
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817873; cv=none; b=aba8o7ljLT93PbVKdMdeiFbTlNmXlFjy3BME15IwICoSqjlaRXN4vZvs8P1FBZjZpWc17vBQgfwAfdY0sXthCPPYqB2zknVElCNnkdOkMj/8DQfjFZ3GF+mQK3eEfWl5E5lGCkOHxAcobs02UVDNNY5gPS596RvkS+FyiZHeOQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817873; c=relaxed/simple;
	bh=uuQY43wa+0cys4WzKZsdo95EDIza7dv83nymBpPfuio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsAtRcTUqpENEq6CVMUF/NTG13QE+OATnWiwAuYtu6gEYMBsIHRwVbiZSxedPtsR+50DlkloVXK3bHIa7qV6eVIK91IcQ08sh/6MqmL9aSNLxVJ/ELPcu3nX0CbQ8gCAaZVpBOcS4P/3N74DP9uOq/nTJp1lUOxAmUXaoXchgS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CEWDhMIg; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-578626375ffso3028877a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 06:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716817869; x=1717422669; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uuQY43wa+0cys4WzKZsdo95EDIza7dv83nymBpPfuio=;
        b=CEWDhMIgwS6jcTyM9CnO7Rs5RJSfU/Ovrj3b06MqDJ6R0YIYvhzNBppzLFJqGSdNmy
         XiTjn+ECfLvvID5/oJgG0etMRFTl4BEZEDxCCZ8SNhtcOx3apaD8OEhdO5DZaGW065Do
         cZdNLeGeLioeciz/B5oH3VdXomvPXOPafXkds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716817869; x=1717422669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuQY43wa+0cys4WzKZsdo95EDIza7dv83nymBpPfuio=;
        b=ml+kVdyQ9/uIZi6BvMArbISMkO4pKhazT7+tTayaQ1gTB1Ihqt39nMN0L5wtsh+h4A
         Qy4hNP/94T23HnBFXjUPcp8hYGI0BIKtlgU0uUV6k9byLT4hA/srNuuGDmz4vOkZtbDu
         x37mmPZsutXWkBGECLrrXNkW9+kc9APW66NggNWAaNHXT0rgNC7fnku/HV5sUTzS6hBe
         wMrp/JLOqFDdm/HSuDMFcCwiw3rqZrtzSoYzk5WVd+mHk2TY6fXVZlJZmlvOMSPFKdVQ
         99LyfRWZm0Pq+w3M8FpMUys83YUvO5gQjGsursGdLslpnTsBymO5KW23CDMNhfp/zmQk
         pSoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG/xxJdtgBAeXFUrtlWnM+5h0v0GzjCjODiEKeaqMFtGycCFqEqVijqmXyLQZXOQq/sOIb4UQn5gMDfAY9N3g4RS5heMcUc3Kk7HXo2A==
X-Gm-Message-State: AOJu0YyoZMnaznzDNc/E2bUXU+U5a9wHdU7A1s/L0Qo7LvoUzIh+qESg
	DBCfCXyvtPhIoBjnGSyYzJFjrFLquI4LW85MW7XQskQgz1So68c8G+zi7jBR702TDg3Rn4zuk3W
	nAuveY97LdL6fqM2YZEx3GP8rl6CjSHC7wUcCzA==
X-Google-Smtp-Source: AGHT+IE+776/I97VJo1iquiMi/Yw2Zf4q5ChRdOsvC6Wn8oeSttS7ENd+orAmozSW0Y0YeHPwc8Ri+zGLINvPPdC46g=
X-Received: by 2002:a17:906:5a70:b0:a5a:1562:5187 with SMTP id
 a640c23a62f3a-a626512942fmr636424766b.55.1716817868894; Mon, 27 May 2024
 06:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f6865106191c3e58@google.com>
In-Reply-To: <000000000000f6865106191c3e58@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 27 May 2024 15:50:57 +0200
Message-ID: <CAJfpeguD5jSUd=fLaAGzuYU-01cKjSij6UbQWy72LDpqK1KQfw@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] [overlayfs?] possible deadlock in ovl_copy_up_flags
To: syzbot <syzbot+85e58cdf5b3136471d4b@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	jack@suse.cz, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, mszeredi@redhat.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
 f74ee925761ead1a07a5e42e1cb1f2d59ab75b8c

