Return-Path: <linux-fsdevel+bounces-79637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBmaCUICq2msZQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 17:35:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 690F622511D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 17:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB3113014BDD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 16:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA8736A01B;
	Fri,  6 Mar 2026 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BaBKQ7Cj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BEB3B8BC8
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814531; cv=none; b=okUaKX+8iXDkEfTWKtsKGM9FQ4I6faftV29IdCoiXtENShZvLowNlqa+97OC4epwkH0gSdSrd3kuF+VfKz+V8O72tRxO9QVXq0TDcMYysgtTNQ7rBgpWhBZdcBf1jluQnOokyOzW5iE+pWGhsUWeFZc/mNXmu+OZJ6+lSgCjdpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814531; c=relaxed/simple;
	bh=cX79kSZCH28VGIfUtFNJ+kXqzh0sITzmmuj1Jpvh9c8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWfouS6wMxkPwr8kpqmWBLrdzQJewdCp3pjOKNDRJxR14sOQ88foZAku7HA3qcj00Rg9kjDaCsLVVaHreljp2NwuK1ceo48S0ZBiTb86KIPu5fXUyD0eTD3R7UeENQhRvjPq49Jt100af11xlR77KaCboPtNeSmD5akckmYUzF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BaBKQ7Cj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9431300833so122134566b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2026 08:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1772814524; x=1773419324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aXIl+Rx1DH3bfO0TDXGYaY5Er/AJrKyveW+IxjspZg4=;
        b=BaBKQ7CjI5ZOEK38a84r07tE3CP2H1lY07crpdUW4fjgQXTJJOOZFJ07nzvaGmUlpY
         BJ9Q0qAXIiX4fAC/iWiYlWCh1bZvag/1XJqiJRQZ69aEI6ZFkAE+INcu9LEteOy50rcY
         1IymEwPnuwQxCA1VOv8FKSKl9aBaeOtanbXNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772814524; x=1773419324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXIl+Rx1DH3bfO0TDXGYaY5Er/AJrKyveW+IxjspZg4=;
        b=V8+QutwORtf1220eGkYc+fghC722o1ducAOUg61A+7Z6+Ye2LxFpYJbbNIj9+bR6no
         HKOrLR0xsYuvhdZyEnJ+izQ91/IoFYzTta2S9WQpoc6m2R74CApZHVZbm+HRz0WYy5Un
         gf3Hjj6gNVSbBvGCf1pwubNJqs2Vct2Azh5PSfHmCEl4RIAfPP54Cu+oPE6X5R9EB5sB
         LrIKxnGjyWhYJPyR3RmyfnN8w8Rz7IcSkU7f6P+ZpYLJYTLKYa1o9PvvdkXuUcEAXqOs
         /3ZuZFF+jP/PBFMg0yVjstjmFjbp4hEzUq+o74XQmnBJhYOOJe2evRjHJjUZYRkdzbl/
         LTyg==
X-Forwarded-Encrypted: i=1; AJvYcCXayx31Foap1jmDFz4m+XicHInG8tmCzkgYPNGiLyRGbcLyugzGAJoUOmM2u7u/58cncGIdSNjWD+trJSSM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrs/Dbk1eai4UEjOnGWw/jxc1ayxlbtGeKb/G/p6uLi9z3+RvL
	LluG3GHn/O3cPz7RbeZfoM4cJ5D7mkYV9FcgYB5hRLGIGz285Sc+6EPrH+W/nWC6SCoTkWJy/2c
	OzMSDdBc=
X-Gm-Gg: ATEYQzxPVtg/PqwwCvwE9TNlx6FtDTiEFwl3PtvZI/4hdfpHAvDlaaq7eF7rfINT/F8
	7j333hM49DcYlM5WbJjHScit3V79zjBukbVRtfnnylPLxWhccwbsjvD+GF/js581PCeC3jebk8W
	ly1+GE88aUo9SyHiXhvl11LmSlC1dU3xwufLPWl4CyLwc5ufHzdZjCAqG3xS10v27m7HBOBrkeR
	yBbKtO9csCbsYYKLKwVfDSQY9+e4UUUDusYUT9mTlu02PdMGBJhc1SQmumPcLjzbLHROn64+bMd
	upPPUht+kX86iSvlBIMwWOokFNKuBXvKzNOfh/YS/R7E0B2lpDV5kCYZlBykQummXxpX5Ej8UXb
	0VDA3Z/VUYEEc/7TUq2RLwtz1la+C3wdoTfgaWqkySV6bmCsOFffL82If36Z5IOXww1CxhdtkW9
	zQ3YdZauBsoF/R5kZTTcdvSCXclxsVSNS8X3/j0ml4Z0uriVr1hAnSaLwjJJEGzOARw4XGT4IBX
	SW6fvLbKYA=
X-Received: by 2002:a17:907:94d3:b0:b87:4bdb:1061 with SMTP id a640c23a62f3a-b942db86962mr154618866b.1.1772814523688;
        Fri, 06 Mar 2026 08:28:43 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942f15c23fsm71804166b.49.2026.03.06.08.28.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 08:28:43 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9431300833so122127066b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2026 08:28:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUEqzdmXgCrrGB5qHHsgDwTrBrpzsmWkvUTKSbQ0QXV4T37RpMcobxm8PEjXQaLXAo0MAHlQVAfXtqTYtAY@vger.kernel.org
X-Received: by 2002:a17:906:2092:b0:b94:82bc:ed13 with SMTP id
 a640c23a62f3a-b9482bcf242mr5892566b.7.1772814522554; Fri, 06 Mar 2026
 08:28:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
 <0150e237-41d2-40ae-a857-4f97ca664468@gtucker.io> <20260224-kurzgeschichten-urteil-976e57a38c5c@brauner>
 <20260224-mittlerweile-besessen-2738831ae7f6@brauner> <CAHk-=whEtuxXcgYLZPk1_mWd2VsLP2WPPCOr5fjPb2SpDsYdew@mail.gmail.com>
 <20260226-ungeziefer-erzfeind-13425179c7b2@brauner> <1ff1bce2-8bb4-463c-a631-16e14f4ea7e2@arm.com>
In-Reply-To: <1ff1bce2-8bb4-463c-a631-16e14f4ea7e2@arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Mar 2026 08:28:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=whEEBaMuM0iR6yY2CyfoLDJZxzWvi1yrCsEBoGTWDVUBQ@mail.gmail.com>
X-Gm-Features: AaiRm50b8ukFOu0LH3eYoVAWaJ2bzveqWv_zfm2sIB1zmUoShkXh3RMYjMBbX0Y
Message-ID: <CAHk-=whEEBaMuM0iR6yY2CyfoLDJZxzWvi1yrCsEBoGTWDVUBQ@mail.gmail.com>
Subject: Re: make_task_dead() & kthread_exit()
To: Christian Loehle <christian.loehle@arm.com>
Cc: Christian Brauner <brauner@kernel.org>, Guillaume Tucker <gtucker@gtucker.io>, Tejun Heo <tj@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	kunit-dev@googlegroups.com, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 690F622511D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_CC(0.00)[kernel.org,gtucker.io,gmail.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org,googlegroups.com,google.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79637-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-foundation.org:dkim,mail.gmail.com:mid,arm.com:email]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 at 03:06, Christian Loehle <christian.loehle@arm.com> wrote:
>
> FWIW this leaves the stale BTF reference:

Thanks. Applied.

              Linus

