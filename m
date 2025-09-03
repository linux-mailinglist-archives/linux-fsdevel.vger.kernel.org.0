Return-Path: <linux-fsdevel+bounces-60167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE07B425C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 17:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911BE568639
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E0E284893;
	Wed,  3 Sep 2025 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="laYqEHqt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F7C285043
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914342; cv=none; b=rK1PQ51f6Lz9jr81pV5xw4PWrWJJLl03FPXxz7Y4g0oHl9fiLVNsVwxEJLyCBpxRn5SzY0cy3zbbFq7l98YE9pI7bBf3ZyOl7nJIdjaxYAMrxBWPBPudPdzTpVUlpLRcDj4Oyu+ImpTF3HS1vz6HsASKBI8Lv1+j7Gw/y2iPFZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914342; c=relaxed/simple;
	bh=z++8Hj6Jl9UrAEq7qR6T6epgO8msJDYIh8avUTWtDe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfHhFwzUGbQhL/PVCJ8fESyc85VaRAST2IfQk0dFBf0zN+kRLJRc4usTxYM47ot92bLaHtS3UHF/OdmvxSBHpjZIRUsuFNe4Sh9Il1gmIYopzWyOwQ54R2s9sKXi9QQaqvtmV4MwG5o0PHJdxJ2YeJ2dzhrVc11KRm8J11AFOaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=laYqEHqt; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b3289ed834so646871cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756914339; x=1757519139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FNtIClZm2rPcNW/M1aZEaGfZVMH7KL7FIY6JjS/oB1o=;
        b=laYqEHqtNIS8ec7pnJ2DZRg0bnn62MZ8cicrkf7gfcvcAqkGjms8AqkVe4Rnd5d5RU
         Azsa5pG0mw7DZVdKf6tiTMuQhFaEeDUFzumPNOcgBf8gpv2kuu4TiGK1q/Nuibn9XreS
         891iBGkO55U2kiIUSA+ZflWKT+AkPcSxVm26g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756914339; x=1757519139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNtIClZm2rPcNW/M1aZEaGfZVMH7KL7FIY6JjS/oB1o=;
        b=sES1lSLlYsUleNPsIkxP6eaDOaME+xsUiST8AoBIEjSrxuG0RDObIs1xbEgefE8AM0
         AHT8birlK/9mEJcop/kEUaIWlL6ZTmulTJFWB30f0r7lJoXsuUFt9phyaPnEqWHfgf0X
         xm5x6W47YwsKKD+5Bv39yAJhQtrNPOAPCS4q6TW31BEhlJiA/VK9subzq0+Mgp0YAiIB
         iHn3sEYGOvQlkJTPD+H32qvLV4+irCC3ikupJCSIDASrnecXY9X0PghM2fGIgwqpXThn
         sjyMt5vkXZJojvP428DQ4xnIhpwKU1YJiU52tyrdn1wL2NHsw8zPPCrgx+jid/4OiW2i
         k5yw==
X-Forwarded-Encrypted: i=1; AJvYcCX/q8HruZ5VZsv34BFp8YkqFmHHtsPnH2Tac0uT0mr919DhQfZgtLKGEoXdVT6HQvPnbzfjK7iZsjOdZes2@vger.kernel.org
X-Gm-Message-State: AOJu0YxuN+maCZcEwQbMrpiLNR06k2Tecnq+LboU8HB5ryh1RkSzNShY
	Y0pPkj4b8rsTge+f3960f7VMi0LO23PGRg+S6BLZNlgRP/DgJ5ymMAxRiBeUtLfrOyL2dfPjioj
	Pky6LXJYL2Gpq6I2bhYKPvFHN+EC/nzefC65aM9MkwJ8RwVc669N+
X-Gm-Gg: ASbGnctHUVmVH9L9UBU93k2Rc0WFSo10sNy/VghTa+xFhUFptvokKXSRubI8Db/yQRZ
	1QeeWRhN+VyfFFi42IGmgv2qWM1dp2YzDHnU0noh9aPsUkPc04eL712ilmtem/1B9o4BdqOLg1C
	5ouTH700gv+noOMORcL1RBesxZgB17AQyMukDJE3WnTzzJzEob7yzM/3EygHTJzE8sDZEKa8zfx
	cOfZT5paw==
X-Google-Smtp-Source: AGHT+IGtp/UqVx676wQKfSsn1clGPgLlQQvcL13XT9QmEAE2nTqp1KO60Bs9nCEWBNonC8hKnHWd5edJ8/43JowtpFw=
X-Received: by 2002:ac8:5f14:0:b0:4b3:1d29:6a68 with SMTP id
 d75a77b69052e-4b31dc8e3f8mr220010531cf.71.1756914338570; Wed, 03 Sep 2025
 08:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs> <175573708588.15537.652020578795040843.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708588.15537.652020578795040843.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 3 Sep 2025 17:45:27 +0200
X-Gm-Features: Ac12FXxJDPgvM1OrKoWLhKD-TqDBHK477b4OO95o1LEhbpja4Dr9wgV4p-r39mk
Message-ID: <CAJfpegu3YUCfC=PBgiapcRnzjBXo8A_ky6YiGTYaUuxJ=e1jmg@mail.gmail.com>
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the connection
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 02:51, Darrick J. Wong <djwong@kernel.org> wrote:

> Create a function to push all the background requests to the queue and
> then wait for the number of pending events to hit zero, and call this
> before fuse_abort_conn.  That way, all the pending events are processed
> by the fuse server and we don't end up with a corrupt filesystem.

The flushing should be dependent on fc->destroy. Without that we
really don't want server to block umount, not even for 30s.

I hate timeout based solutions, so my preference would be to remove
the timeout completely.  It wouldn't really make a difference anyway,
since FUSE_DESTROY is sent synchronously without a timeout.

Thinking about blocking umount: if we did this in a private user/mount
ns, then it wouldn't be a problem.  But how can we be sure?   Is
checking sb->s_user_ns != &init_user_ns sufficient?

Thanks,
Miklos

