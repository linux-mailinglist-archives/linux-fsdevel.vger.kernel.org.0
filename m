Return-Path: <linux-fsdevel+bounces-10672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F9C84D387
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 22:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8DC1C21B1D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 21:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A1012836E;
	Wed,  7 Feb 2024 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Q/YldqDE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C370127B65
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 21:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340586; cv=none; b=YI9/DSn0uu3beYuk9vQFdZ7pdMNgvb5dJoz3WKXX2b2d+mwWuSO10PCevYN+or3bQWMekBp+clYvABNJW5gRoiK+epYAC3vsB4tyHJduSzUtltCpxhwJ82UkNPkJSsMVSwDNXrzxr3slbGiJ0mHHQsb8y9/n6k8qe+7f/9mqMLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340586; c=relaxed/simple;
	bh=w+fIBjPrK/nT6xuFbVQ1juBBDVb1ZDo31jplpYMA5n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+iDkaSAtbIHV69TwBE5KJ5/OFGXetlPBxVwE72GqPj9v6IBdQgT/T2rL9GTcfbUHimQMMXfl3xNNBr9ZO9BcXdefQB95Bjk8OQUE6IPOFUJFYVbBwNJc9Ae9peTYKlqp7pb+Dh22ZIXfuad51Acq17xOcMkuI1tzVUAdb/slLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Q/YldqDE; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so741219a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 13:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707340584; x=1707945384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Gqlkqgjh5mviyHn6MD8miUxLgv9IqeBU6I07NHmQEg=;
        b=Q/YldqDEbY/bCM6JheFI9FpScrpdO78vVb50ro+eZbfSXo1YK7LE1RsrUMnMNTko8U
         6m/Fz3A+JXA1Y4+YYuYdA7eQ9krWvg32mPwmMpWimR6Uy6n7vX4TPkdWkdILIw93Au5s
         oSEzh5j28cdFrPI8PQR3934x//JWqcbLxe9MJTtCt4zKAHQrksVBUEYizrWWqJu5HQ6w
         6eY4Wu1ggECX3O0Yg6RTHK9XE4y+7serA+adPVf5A+vsUb5FeDmSLdHuvKNyZBAwnxE/
         Dfz4Tf4rlRUD9OwRnOWdNxzxg1n2hr3N1FUdexSIdprGmzT3fgD0Y0WSoJgp+03WdMwh
         tDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707340584; x=1707945384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Gqlkqgjh5mviyHn6MD8miUxLgv9IqeBU6I07NHmQEg=;
        b=dLW1B39z/uY5xlfPFV5UR8u54F9C8zyseYn04uEx0tsbI4KaUPj318PuOANNnbScxQ
         IOWn9ehyRAphjjsS241908SvT5tVFBLJ0oYcGJMNwcsyVxtKtutNpZ7OHerOXz1yx6lI
         qPUPRGBCyhxyjCJ6EatsUtF64bMFGYlME+UuUNwvum5I+7MEzvZp1vE0BntUOpCOBY6I
         RD9dK9/E72fPnAAZk/TsZwHfnLQqg/DtEz48rrtYL+ZLVLl9/q/PMdhjHp5JYP7PktBD
         7Pg0r3qoYn9TUqT6JYStq3YI/D6S6zLiIYdH0U/XWh2hQ1lj29qg4SK40lz8G1WiUJTe
         sUiA==
X-Gm-Message-State: AOJu0Yxc2cPBBY1JEPfHp+RK5FLDNW9NNryvWW4gMrvACU46CYtUyQvN
	UMLQ5RJUVBtdmh85D2ic8lSQYzcxl/0WZ1PrRhtJIjZIaMX36enXKDL8AFMV7ZM=
X-Google-Smtp-Source: AGHT+IFePLqKUcwz7TT7inMgRHMqSnOOGtNeTkWD1Yt+i5WWwKtaMmhtffaSfHUiH8/oQpO8GTuxKQ==
X-Received: by 2002:a05:6a20:3d0e:b0:19c:6a9c:2c76 with SMTP id y14-20020a056a203d0e00b0019c6a9c2c76mr7209700pzi.10.1707340584431;
        Wed, 07 Feb 2024 13:16:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXb2OVOLLZHdGwuFn/U1Iyk1hXgiAvRmYL2Qd14d66VH8Ss+iP7b5sf0SgSU2ALeeGHpJkdpcAkeIXxqTtjEjZpwCfOPpqGAjuntcTs7iAcihTMjkRvZri8Qz2SNCEz518PVL3NyHcV2A8zvlPGCwzsblGKk908BMoVuCN+F9U0XAD/qDuOY/EXM1hf2sq1h6Wcqv8WBreHLeE6hxRbP0FuBLlS4Fdpyck5eKhRIbulRlLcS6uVl5CTj6/PPdY1CHCHHlf4eQV05tEmN8k3gSnVZ/+CpI51QcvjTCk8fnE7OpkZPz987nPyFjCh5z1D2KbLQxU3SK2D4DW9Dc5XWKPhjPDfebnXv7knUHwCH9VSHILvVjYdEQfDRFp4Dv8phRq0zgRTFp+1T1DMGaW7Fml3ZAemDTjV6CNpe6ugeMguOg==
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id d20-20020a170903209400b001d8f111804asm1911449plc.113.2024.02.07.13.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:16:24 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rXpHJ-003R7L-1Z;
	Thu, 08 Feb 2024 08:16:21 +1100
Date: Thu, 8 Feb 2024 08:16:21 +1100
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+9d0b0d54a8bd799f6ae4@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, chandan.babu@oracle.com,
	dchinner@redhat.com, djwong@kernel.org, ebiggers@kernel.org,
	hch@lst.de, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	sandeen@sandeen.net, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] WARNING: Reset corrupted AGFL on AG NUM. NUM
 blocks leaked. Please unmount and run xfs_repair.
Message-ID: <ZcPzJWwhd++wGtd8@dread.disaster.area>
References: <000000000000ffcb2e05fe9a445c@google.com>
 <00000000000053ecb50610bfb6f0@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000053ecb50610bfb6f0@google.com>

On Tue, Feb 06, 2024 at 04:24:04PM -0800, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1110ad7be80000
> start commit:   40f71e7cd3c6 Merge tag 'net-6.4-rc7' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7ff8f87c7ab0e04e
> dashboard link: https://syzkaller.appspot.com/bug?extid=9d0b0d54a8bd799f6ae4
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ab4537280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148326ef280000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: fs: Block writes to mounted block devices

Hahahahahaha!

syzbot, you're drunk. Go home.

-Dave
-- 
Dave Chinner
david@fromorbit.com

