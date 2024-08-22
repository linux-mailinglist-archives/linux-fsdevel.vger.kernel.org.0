Return-Path: <linux-fsdevel+bounces-26825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A985995BD93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 19:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAAF8B24E0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4C21CF293;
	Thu, 22 Aug 2024 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GDMvq8z5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7771CEAC8
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348615; cv=none; b=eggmqLE+iKJD7Wjdh/QjUHYloMRpSHwpCXJLc5nFS225UkfC0f978j9xe71EHLfmISLRU+kOqCCq0N96OBMq3bOPrT0X2UWUDvWy+LxMdZLhracUTEeY4vj4IgMup+wrD/Hl7MMZozG6w7UhwHtaoo4A8EMtm7xHrfCKpIcWgRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348615; c=relaxed/simple;
	bh=JsRkeDEZZRDdpv3zs63vC7FUvez+pb9FcpluTWZ6hO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpMNZwu3DV22uI4w4MM99NMVa7Nb2VraKUqSFp6QZ8nqJJ6PdTpJdasi3eTtyLNzxtrD/9PztMXz8vOkYAMFNhyLNKt54AdD/B063QCtvE6E6v24g+3GAtleoZdgoQTWYv2RFKf1p5wtiBX7hpDAn3a2BUhMFF1oj1VSW9klZ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=GDMvq8z5; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a866cea40c4so136000266b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 10:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724348612; x=1724953412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JsRkeDEZZRDdpv3zs63vC7FUvez+pb9FcpluTWZ6hO8=;
        b=GDMvq8z5hLuApsqjjSRulY4tTkUyLgFs19h8cTmbpFz7bf/HXBdt7GVJ72PVy2E2nX
         BmcN+8+SA/ih1eiCzu6W1LNDjY80uqloIBVT21Uf2K7Z5Xph9CorH+7/xocVyBxsxloc
         ZALCK1FypP8XxyMuaoH1EqA+k0LFg+2vlLDlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724348612; x=1724953412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JsRkeDEZZRDdpv3zs63vC7FUvez+pb9FcpluTWZ6hO8=;
        b=FRdU86QeHiJGnWrP+3pt565zSG6QU0CZQ2yCougl0FkmYKyM3aErG/l2UGH/kXHZ4/
         u7Up+WCHRMSVHpkBtkprG7shyMOe/fENKt6M9i+zJX4/bXfDtArOGigQMMzQI8pBWgxc
         /H73s44WCDQaSCOeqswBGb78dqt5PR+u+YeNrkklY4YhwXjQc4iTl0t/pwUzpnGdZ+V6
         T19ZSfV99VU131+KXnZus50qf0R9YNJn0IiMzjTW+NaERdfyA8a1CGKEwjOLOHWhROcX
         BrSZrHLHdMUyXMXXrPXux7xsZAaBrt/Gh8MLWq4bQ7/c86eJ2o4eAjhnJXB4iZ+4lsQv
         ofnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe9/9H0wx9sCDRh5H5nnahXqqsAm1zZiisb4YvLb12Y0k+uUNxzNXTC+vpUwG3GwFuTTq9gbb0FFzZRBHa@vger.kernel.org
X-Gm-Message-State: AOJu0YxEyR0nd1ckASWj+5NRVCjJ/BItibN0ob8V0zYmUkPTGpiup6Iv
	JYWF6+KCtfQx9pYgxt0iGbR41n9sRLdjzKUDCPk/YErwrXcLYu/aJ5NjWrqagQFigErWkTHhPm8
	REvw6KQTwV60uvoretfVuUGOaz4YDr+kIvhsynw==
X-Google-Smtp-Source: AGHT+IGJON9HzI8XelUmop8RtfufK//HgHUdoDVNa254D32fOBvjQjrsB+vON2CfG+ZmO5wi+dWtcIC4qZ/L95f/how=
X-Received: by 2002:a17:907:6d1e:b0:a80:f79c:bc44 with SMTP id
 a640c23a62f3a-a866ee5c89cmr518660466b.0.1724348612175; Thu, 22 Aug 2024
 10:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813232241.2369855-1-joannelkoong@gmail.com>
 <CAJfpegvPMEsHFUCzV6rZ9C3hE7zyhMmCnhO6bUZk7BtG8Jt70w@mail.gmail.com>
 <20240821181130.GG1998418@perftesting> <CAJfpegsiRNnJx7OAoH58XRq3zujrcXx94S2JACFdgJJ_b8FdHw@mail.gmail.com>
 <CAJnrk1b7DUTMqprx1GNtV59umQh2G5cY8Qv7ExEXRP5fCA41PQ@mail.gmail.com>
 <CAJfpegsPvb6KLcpp8wuP96gFhV3cH4a4DfRp1ZztpeGwugz=UQ@mail.gmail.com> <CAJnrk1b5_7ZAN8wiA_H5YgBb0j=hN4Mdzjcc1_t0L_Pj9BYGGA@mail.gmail.com>
In-Reply-To: <CAJnrk1b5_7ZAN8wiA_H5YgBb0j=hN4Mdzjcc1_t0L_Pj9BYGGA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 19:43:21 +0200
Message-ID: <CAJfpegtFRy=cKQdQGuqcwh3+4MM2u-_c-Gc04U06a8LJQfiG2Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] fuse: add timeout option for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 19:31, Joanne Koong <joannelkoong@gmail.com> wrote:

> For cases like these though, isn't the server already responsible for
> handling errors properly to avoid potential corruption if their reply
> to the request fails? In your example above, it seems like the server
> would already need to have the error handling in place to roll back
> the file creation if their fuse_reply_create() call returned an error
> (eg -EIO if copying out args in the kernel had an issue).

No, the server does not need to implement rollback, and does not in
fact need to check for the return value of the fuse_reply_create()
call unless it wants to mess with interrupts (not enabled by default).
See libfuse/lib/fuse.c where most of the fuse_replu_XXX() calls just
ignore the return value.

Thanks,
Miklos

