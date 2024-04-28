Return-Path: <linux-fsdevel+bounces-18029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD1A8B4E11
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 23:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E62E9B20BBE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 21:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AB6C144;
	Sun, 28 Apr 2024 21:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="bIJNctnC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB828F4E
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Apr 2024 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341491; cv=none; b=QSVGRfACMLTwB+Uvlr6X0Ei+2n6lTP5YHEMmDqs9AKkxMokPleBsaVpf2TJFRduaYMkeH5S3JxEKw4C6nFypC6L0VxNot24mkqGkoSIjKnd/Bjk+yONOfFSha5FJZwg2Bl+vh42EuYu1nlGIvWOnKRvj31xMLst4WQdoQ1hcA9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341491; c=relaxed/simple;
	bh=tdAhCl7mjJa8RjUt4m4/7T2fZ2dVw3IwCO8GrNawYNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsILOapr+J5qdsIj2xLmQpv+mpN+FiefTrF2kwvmuOl+nOnEUAaFS2g2Wo8QiIB1aGzb+UtstcbtboXMOA7F0/3v80A6hKQNTLN057/ZXgAQCevRwpOLpK+W9Ph21p6ZCVkeXgu617jimAMQQNkJLkEP9tVzUdrjMzQKIwpjCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=bIJNctnC; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed01c63657so3699509b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Apr 2024 14:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714341489; x=1714946289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXuV7csRtJz4GGD7tR7/rDnQZRyGku0WW8DuEX0XcjY=;
        b=bIJNctnCWEY9lV3LZntTmI5WvDBMx1KFZkm9CIn25Et6vGQpLxi5cUC+JVyK3btS1w
         ep8CNfUn1x+UPTsLHKczGOmLnhdLQ6rd4E5Y438D3aqEf2thRdILmeXpGtMtdM76Sa7m
         ENQJW3e0n/sjT0g8v4cvtq+s6GjVV19WWqxH1UPvGuQoah7irri5JfOGuJZr/OOcUttO
         6pObWAZl+nmnPzzoxuanQA/YCPUoTfK5dJrKutlodSPvaTaa6Eg7Xovs7pBSkyIlYH9D
         hqqMl+HNCsp+grtDj0iMebnR3Ctug9eu6ZPlqmXTDBRV5Yt7PqLvrJPZjKIaMVDPIIvE
         cqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714341489; x=1714946289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXuV7csRtJz4GGD7tR7/rDnQZRyGku0WW8DuEX0XcjY=;
        b=mo8XKvtPhUFo9HtSOr84AiWTLPeIqVNWx7YQqplMkUmY9dxlPKEKPgfnlYO5z9jnqX
         SUYc+S+Gbdv6HzA8SVu2Ghq427lhJB49pbXbAY/ApExEWAZE5BQ9TL9YnDDxJEsLnIs8
         D9TWUig4u9YwoyNae0Jk1sA232LSxVgacD8h7EM5k+4ZcBrRQJ1OAwwDV+qMWd7wZT7N
         myZtv0woQ6ji/wKPwsQoBTjGnMDABiTrhVHDS9u6L42KtYgtRncomC8ltCybKteHuvFU
         hEKoEmB2ruBYvmOlLL8+HlLNcBYR48qKCCT7IzZA4QIT3LRI/HIKz6U8QSqbtEbO3RGQ
         cuxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt8GAOL0cMdiTnwCngL1Yfqfe8uyR6ahpMwtUmWOqYLMlo0q3ONfu5ksnJyZY+BthriId7UrHlTClkGHu+hp6SiXBoU9jaMi9j7kiGAQ==
X-Gm-Message-State: AOJu0YxGHsLtwKSAluqyky2//WPDDeASIsshOkkctVNgTz2eJ9OzlL04
	fE9Zh9IX3bb8BFOQHpp/9kWBr4Yfhsj8yknIrYQlDkXeTP/LJyn0HM2HMnypQOs=
X-Google-Smtp-Source: AGHT+IGye1ehSZZt4yT2nFPbQ7vud3lFr2xIjqVEFKvhITtSxlMsboN0QCMiyts7aBjcuVaOJTfFww==
X-Received: by 2002:a05:6a00:4fc3:b0:6ed:5f64:2fef with SMTP id le3-20020a056a004fc300b006ed5f642fefmr6735175pfb.17.1714341488792;
        Sun, 28 Apr 2024 14:58:08 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-29-7.pa.nsw.optusnet.com.au. [49.181.29.7])
        by smtp.gmail.com with ESMTPSA id n7-20020a635907000000b0061236221eeesm1876214pgb.21.2024.04.28.14.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 14:58:08 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s1CX7-00EKuy-0J;
	Mon, 29 Apr 2024 07:58:05 +1000
Date: Mon, 29 Apr 2024 07:58:05 +1000
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+7766d4a620956dfe7070@syzkaller.appspotmail.com>
Cc: chandan.babu@oracle.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] possible deadlock in xfs_icwalk_ag
Message-ID: <Zi7GbdillYG7gSB6@dread.disaster.area>
References: <000000000000a1ce0006144f7533@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a1ce0006144f7533@google.com>

On Sat, Mar 23, 2024 at 01:09:28AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11525d81180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
> dashboard link: https://syzkaller.appspot.com/bug?extid=7766d4a620956dfe7070
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

#syz dup: possible deadlock in xfs_ilock_data_map_shared

-- 
Dave Chinner
david@fromorbit.com

