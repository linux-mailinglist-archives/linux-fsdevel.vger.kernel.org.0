Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72958156FAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 07:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgBJGoQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 01:44:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35203 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgBJGoQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 01:44:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id w12so6076295wrt.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Feb 2020 22:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arangodb.com; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=92GMes+qU6VV1JB9KjYdvZUPcleG3njx43ni4N4KD7I=;
        b=dbvkSF5Eb7fVuPBoZNYzxSVaYyK9a9ynIZnDIpc6uXswr/HOk8Zv+ih8h3aOVEdbgA
         LjDArPw1b73Gqzf2SFnGtWOmqVL1UkUpwgPJ9rKn+Hd0/GNHUMWeslzn/1/X1y8IRDQL
         OaEhoym7UdrRpNUiROgIY2M5LGlpmbew8TQbTL4rP65PBSEZYeeYpi0KX2Ik3EqIABgN
         DRokHZM84eruQLi3/wrhXh79lNXNA4zziX6pBAQmU3HnMciht/Bm4fYYY9yT2ComSJPt
         0XJ7C8R4d8xq14QWqyEwU04xsVxDgeWw9eIaABCp9fX4nnsJrKRqE6MAG4d7Gd0w18vO
         C4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=92GMes+qU6VV1JB9KjYdvZUPcleG3njx43ni4N4KD7I=;
        b=hbwpbVlu5P68KqRz/3Ln8VhiHsxjtwB374wix083I4SOrNc+8oOtxT4MwH7VZxvSDu
         OtN1IAD5Q9VQjuhHn7rI4BHQbcxL/8/OOf43Hhiw2mgDCiRd0xAGpmFrNpMXerpqv+Ln
         E9mxRVb+9ME3F5tgHzCtmfzAfZzLQZ0aGrQI8jrwtlO5JGmf96Y+jT0MTul4Gsq+Vux3
         HO42zzIRg5lqXQeP30A5Ce/3pscdd0fkAnKFrznsjysEqTEePQ4/hKIdnwUE6LeYm6bd
         k97A2U6zEk1pz3EklHAyLFtmuysvFqq06XjDKp88WeUGBL2yq4Yb2zfRE5EoIAojfd5l
         uv/g==
X-Gm-Message-State: APjAAAWVXnliEfPkjivCee6a+m0zVP9kH3R0hmtypgPbxFLM9BnXPuFj
        342nJmPNyvSUgpHt+7fMZSTk
X-Google-Smtp-Source: APXvYqztHTdM5H0tyheXb7+znANDYookR+wsPkCnX1uwrwiSdD682N9aCeBjoUANmamG3gihvkxGFQ==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr14991230wrt.367.1581317054187;
        Sun, 09 Feb 2020 22:44:14 -0800 (PST)
Received: from ?IPv6:2001:4dd1:79f4:0:a0db:8cd9:1ed9:8aff? (2001-4dd1-79f4-0-a0db-8cd9-1ed9-8aff.ipv6dyn.netcologne.de. [2001:4dd1:79f4:0:a0db:8cd9:1ed9:8aff])
        by smtp.gmail.com with ESMTPSA id s12sm14743688wrw.20.2020.02.09.22.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Feb 2020 22:44:12 -0800 (PST)
Date:   Mon, 10 Feb 2020 07:44:10 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20200209215916.15640598689d3e40aa3f9e72@linux-foundation.org>
References: <20200203205907.291929-1-rpenyaev@suse.de> <51f29f23a4d996810bfad12b9634ee12@suse.de> <20200204083237.7fa30aea@cakuba.hsd1.ca.comcast.net> <549916868753e737316f509640550b66@suse.de> <20200209215916.15640598689d3e40aa3f9e72@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] epoll: fix possible lost wakeup on epoll_ctl() path
To:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Penyaev <rpenyaev@suse.de>
CC:     Jakub Kicinski <kuba@kernel.org>,
        Christopher Kohlhoff <chris.kohlhoff@clearpool.io>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   =?ISO-8859-1?Q?Max_Neunh=F6ffer?= <max@arangodb.com>
Message-ID: <96BB34B1-0544-4CB4-A93C-62646753B46F@arangodb.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Andrew and all,
Sorry, I did not understand that I should explicitly give consent=2E
This is fine with me=2E
Cheers
  Max

Am 10=2E Februar 2020 06:59:16 MEZ schrieb Andrew Morton <akpm@linux-found=
ation=2Eorg>:
>On Tue, 04 Feb 2020 18:20:03 +0100 Roman Penyaev <rpenyaev@suse=2Ede>
>wrote:
>
>> On 2020-02-04 17:32, Jakub Kicinski wrote:
>> > On Tue, 04 Feb 2020 11:41:42 +0100, Roman Penyaev wrote:
>> >> Hi Andrew,
>> >>=20
>> >> Could you please suggest me, do I need to include Reported-by tag,
>> >> or reference to the bug is enough?
>> >=20
>> > Sorry to jump in but FWIW I like the Reported-and-bisected-by tag
>to
>> > fully credit the extra work done by the reporter=2E
>>=20
>> Reported-by: Max Neunhoeffer <max@arangodb=2Ecom>
>> Bisected-by: Max Neunhoeffer <max@arangodb=2Ecom>
>>=20
>> Correct?
>
>We could do that, but preferably with Max's approval (please?)=2E
>
>Because people sometimes have issues with having their personal info
>added to the kernel commit record without having being asked=2E
