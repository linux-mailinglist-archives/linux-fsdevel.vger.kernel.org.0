Return-Path: <linux-fsdevel+bounces-58617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F7FB2FD69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 16:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8A2AC12EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 14:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EA52DF711;
	Thu, 21 Aug 2025 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqVoQXge"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187992D7807;
	Thu, 21 Aug 2025 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787576; cv=none; b=FWkz/SdTKKPFKF0JLmls1hWvVCZC8VcINB9TmYHdbhECx1HNYL3+18c6NspoJN2oCPoRDmz4tG1miZQVpLGM1n4gwmGH1CZ9MmzCCXFXO5w9cSKpNVG4k/nAT0Awxm6mqwjccgtwzS1M0Zx0VYRIOkAEgqGmasJl3WQcq7DBY+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787576; c=relaxed/simple;
	bh=+4n4utJycwA3AgzQiJvu/ewM4+9QABDzfmE0ooAk+9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6IHIsBz3vR8zPKZFWsV+SKaMpD+OkfPSIbKVLDGFzt1Ls6/3XlHbh2A+mDhEdssqqhRiTN/viTrqv16Bd40Ue6IVSlBFlKbLY5QT1pBznsbZR7DmyhD7b9jwNraxkL5iEpACbwmWiMhwUnQdmmQ2zuQ+ykWsa9QJY4mtt/mnsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqVoQXge; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb78fb04cso146794466b.1;
        Thu, 21 Aug 2025 07:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755787573; x=1756392373; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIG+w3J97fChnrmJiRIedihpzfaTzFXkYAGxoj1msbc=;
        b=AqVoQXge4f8XKgAkV7MwOXYnIvKnTpJERlLRXE5o1I/cTt8eOjyTntq5EBFH6Yvwo5
         sPbrtacyvY4b7b8rpYReQWypmCQ5+EaZyxg5fDuxx6aUjSQKXl97QR6Ow6g5IYuaR4xg
         V9uS1eJJpzwtYNrba8surhmOUUAKh94/sf/s3hJfOZZMq8XiexriavLpUhowiUmNL7Hv
         n/yGHT2YMdEj42gsWBPXYRwQEqSAfNVeIvrjaVXRSZKVqYJONit1adpyPY3DBnBkgCQK
         QnPj463BBwJDls+NJ/yfj8ScJUU3iObiBmbpod22MQtqVTVPRbryeoelmWhEkjCwxD7I
         Iy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755787573; x=1756392373;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JIG+w3J97fChnrmJiRIedihpzfaTzFXkYAGxoj1msbc=;
        b=eQBytU54YdhqbUOnB3+xe0nrujljX7GxtXpjB3W3SBv62tAHMYFhMUqDNH9Ru0YGBw
         hdj0B/SWzy1X3d7Z3YtFEFHOg7qw9ffOCt7xMDIEhSoTw6P1g6F5aY2d6I2H0Om4qT1W
         GjmX7tLGbIrVxhQ13dcoqtSmKwJfO+BigE6lvzkFyM8x5DvG8gvixyfs89f34KiJyXq9
         OksAkgsFKNqT/4n1797MpEwGVUV5Ds8CILIJ6jKQR7H93g5EjkBsVQedEIfuayYzfjkL
         IrtHgdC8mdKPlWW8eDjf160J68OmvnodgE70oEOSrlhy3/jqPNAkIl9WWDj93T+EN9St
         MjcA==
X-Forwarded-Encrypted: i=1; AJvYcCUlcz9w0asp0bUMmRqqVibDgpKYurMxu89yUXtgQEWRuENA8mEtzqqrBcMPwZQymZYSUUSe20CLdXSo/dOTyvY0@vger.kernel.org, AJvYcCUqETeRT0u+dqfxyJuGVvvnSHJ2PztdZvWJpdLLVnwujso4XFxE4O+l/EQktPPWiEJ2wQg5flpX@vger.kernel.org, AJvYcCVcPRatREGm3rqxXcP2VMQoz7Exy5hm4eZRU1W0pupFwS1Xq01N9hST4skFr0n6wTCkOSDMqYFa44IPx4UIAjjz+mE/1pJp@vger.kernel.org, AJvYcCW9x+AsI2JoiY/2ku2GrFh1Ztf37yCFlXGRjdEkg73q2BQPCQJd0VjuH7wWuY4LIcd19SAxTa7Tf/hVQg==@vger.kernel.org, AJvYcCWCikeRm3+KgSdeEays8WdhfZDEcp/sHxSn3sQV0MqOnuiXuHrP+yO/IpJS7g+ZMBq/h/uKp4CkMxXzagD+rw==@vger.kernel.org, AJvYcCWYngZVbeocT5AqRqDqScjJqnv/z9pYNv5bXXuxkC4lO67lMPs+eJshV58TRCB3+USOyrNfNQYJ4ADs7tvK@vger.kernel.org
X-Gm-Message-State: AOJu0YztjZciqUPxzxhXB7dtr2fFtWoqjnPaw9JGJCYVfaYI2FgLMTUD
	vcVQBTsOjO3prEo4hlVBXGq15/0M4ssAWvGrDLY1Tb/3KB57pc5JHwMs
X-Gm-Gg: ASbGncu+PUyAvFa4XMGtvgyBq0tzZDMxnl5hwuOVzfgdxa/biYCejwxYf873nHYcOUI
	RjvPD2fPtwYUq3sq7uf7H2hI+dqBTGW2Ph+QwFFzfp0GVYTVF82w7NPAyxetY350GGT8OYX4rdX
	4TlxswhKE7u+M+kLE7FK53YeOT0S23e+J78arzlKl7PT2xW7FilDO6gsJhAGp9bms8TLt66xtPN
	6CHTCDdwscDuykS5G4ek2xJEmdkzahTKioy975WUlKL0KbQx1JKYttqys4wt3ytkU7iqfnIow8B
	EhY3eQK3aYlYZ4AEBlwClQm/w2bwJu4vxfA4Ebe8mKJ6OvVtptZP5Tr3xBTPHdmDfrplHUYe9qG
	EDU9j++vCPVStG8H+hPdmOwtc5NFqMXE9
X-Google-Smtp-Source: AGHT+IGLVuYVD4/5frXWAQs5H5qLefX8r3lwrN7PcOc+bxumtnjbgdiK8HV2S0+1muwsZBsiec73zw==
X-Received: by 2002:a17:907:1c17:b0:ad8:9997:aa76 with SMTP id a640c23a62f3a-afe07b96fcemr266557066b.37.1755787573131;
        Thu, 21 Aug 2025 07:46:13 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afdfa887a90sm289060966b.11.2025.08.21.07.46.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Aug 2025 07:46:12 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:46:12 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, mic@digikod.net,
	gnoack@google.com, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, ming.lei@redhat.com, skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] selftests: centralise maybe-unused definition in
 kselftest.h
Message-ID: <20250821144612.a26otz2yriqb5gdq@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250821101159.2238-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821101159.2238-1-reddybalavignesh9979@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Aug 21, 2025 at 03:41:59PM +0530, Bala-Vignesh-Reddy wrote:
>Several selftests subdirectories duplicated the define __maybe_unused,
>leading to redundant code. Moved to kselftest.h header and removed
>other definition.
>
>This addresses the duplication noted in the proc-pid-vm warning fix
>
>Suggested-by: Andrew Morton <akpm@linux-foundation.org>
>Link:https://lore.kernel.org/lkml/20250820143954.33d95635e504e94df01930d0@linux-foundation.org/
>
>Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>

Looks reasonable.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

