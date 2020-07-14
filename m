Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C7721EF35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 13:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgGNLYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 07:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgGNLYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:24:22 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CC8C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 04:24:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l2so5068964wmf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 04:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kShGsztpJubyW8F4tx0kVgpgl8mx3Q9oApw9u8aOREo=;
        b=XXBMO50H/KuyDOJp/szX94CMpIhLBccHyLWxgqh8hqikXcMM7WNbIDFLrBqq5kKUvS
         L00mHmQMYg0a9aEWJ2awU9hbwPGUegny6u/jPQ98sWy3c5KvCj6c7g68Ll295/3XPXeK
         tGpxKVt3fzcLT5xWMyV385sZSd4oiZv4oIpHmMFIc9YeT2bpbxUflQS/jfWcEvk3k/4s
         49haJZTYPy5L/8Y+DMPnag/Cc7kJHX/fI9tscGFrICnf3HgQjvV7tXsKWS1em5isK+MZ
         vyoKxVWmsmETxq2X/jB4zSxfJ/huIAdQ9vO0+MWsXljaYjhbbZXZa6Y8iti35b3vP127
         lWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kShGsztpJubyW8F4tx0kVgpgl8mx3Q9oApw9u8aOREo=;
        b=t9NGjey8QaU1GQ6Oj97rP8l8g5jH//T/IVAvuab2iCsqkAVaFNW/CtKWVzM00i1JMV
         hsFcZjbGMaFboUZ5JSbP4JTFF0YhHR8c8fVZEdrvrvpwWnmIh3JOqbUXhiGzINQs+XKK
         rofwpF3Vm7dgXTOv1xJEW9l1Wml+4tktXnleoy74U8fB9sjTv6NF6XhG4fZD4mZobt7o
         xJE2ccUfxVgWgQd+shTb8USGwQB+A+Y6FMl5R7475aYsTUu3KJXJK5FwhdUdg+iBg9ar
         pOSFtePjF6CwbBbDMjuPfRdGFtdjhr8wau6qP0muOm505WYnabT7rYGseHyO7Uvuse18
         Tekg==
X-Gm-Message-State: AOAM530bMWZVadOiG+yQndBOwMLSFDC0harBQGhJZUo5k0qyIQLyOgCp
        OSXxUSSOuVvgexDFkCBjK6TEiB6hO+0=
X-Google-Smtp-Source: ABdhPJzeVwW9Qq9uk2XYBPi/TnMfdcOH/3+oWRvh8WZR3d501cGnsZCUApTkTnSTKIvsZxp0O5vgtQ==
X-Received: by 2002:a1c:4183:: with SMTP id o125mr3820396wma.101.1594725860530;
        Tue, 14 Jul 2020 04:24:20 -0700 (PDT)
Received: from ?IPv6:2a00:a040:196:431d:6203:64fa:e313:fb47? ([2a00:a040:196:431d:6203:64fa:e313:fb47])
        by smtp.googlemail.com with ESMTPSA id s8sm28152750wru.38.2020.07.14.04.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 04:24:19 -0700 (PDT)
To:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
From:   Boaz Harrosh <boaz@plexistor.com>
Subject: Unexpected behavior from xarray - Is it expected?
Message-ID: <9c7b1024-d81e-6038-7e01-6747c897d79e@plexistor.com>
Date:   Tue, 14 Jul 2020 14:24:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Hi

First I want to thank you for the great xarray tool. I use it heavily with great joy & ease

However I have encountered a bug in my code which I did not expect, as follows:

I need code in the very hot-path that is looping on the xarray in an unusual way.
What I need is to scan a range from x-x+l but I need to break on first "hole" ie.
first entry that was not __xa_store() to. So I am using this loop:
	rcu_read_lock();

	for (xae = xas_load(&xas); xae; xae = xas_next(&xas)) {
		...
	}

Every thing works fine and I usually get a NULL from xas_next() (or xas_load())
on first hole, And the loop exits.

But in the case that I have entered a *single* xa_store() *at index 0*, but then try
to GET a range 0-Y I get these unexpected results:
	xas_next() will return the same entry repeatedly
I have put some prints (see full code below):

zuf: pi_pr [zuf_pi_get_range:248] [5] [@x0] GET bn=0x11e8 xae=0x23d1 xa_index=0x0 xa_offset=0x0
zuf: pi_pr [zuf_pi_get_range:248] [5] [@x1] GET bn=0x11e8 xae=0x23d1 xa_index=0x1 xa_offset=0x0
zuf: pi_pr [zuf_pi_get_range:248] [5] [@x2] GET bn=0x11e8 xae=0x23d1 xa_index=0x2 xa_offset=0x0
zuf: pi_pr [zuf_pi_get_range:248] [5] [@x3] GET bn=0x11e8 xae=0x23d1 xa_index=0x3 xa_offset=0x0
zuf: pi_pr [zuf_pi_get_range:248] [5] [@x4] GET bn=0x11e8 xae=0x23d1 xa_index=0x4 xa_offset=0x0
zuf: pi_pr [zuf_pi_get_range:248] [5] [@x5] GET bn=0x11e8 xae=0x23d1 xa_index=0x5 xa_offset=0x0
zuf: pi_pr [zuf_pi_get_range:248] [5] [@x6] GET bn=0x11e8 xae=0x23d1 xa_index=0x6 xa_offset=0x0

The loop only stopped because of some other condition.

[Q] Is this expected from a single xa_store() at 0?

[I am not even sure how to safely check this because consecutive entries may have
 the same exact value.

 Should I check for xa_offset not changing or should I use something else other than
 xas_next()?

 Do I must use xa_load() and take/release the rcu_lock every iteration?
]

Here is the full code.

<pi.c>
#include <linux/xarray.h>

#define xa_2_bn(xae)	xa_to_value(xae)

struct _pi_info {
	/* IN */
	ulong start;	/* start index to get	*/
	uint requested;	/* Num bns requested	*/
	/* OUT */
	ulong *bns;	/* array of block-numbers */
	uint cached;	/* Number of bns filled from page-index */
};

void zuf_pi_get_range(struct inode *inode, struct _pi_info *pi)
{
	XA_STATE(xas, &inode->i_mapping->i_pages, pi->start);
	void *xae;

	rcu_read_lock();

	for (xae = xas_load(&xas); xae; xae = xas_next(&xas)) {
		ulong  bn;

		if (xas_retry(&xas, xae)) {
			zuf_warn("See this yet e=0x%lx" _FMT_XAS "\n",
				 (ulong)xae, _PR_XAS(xas));
			continue;
		}

		bn = xa_2_bn(xae);

		zuf_dbg_pi("[%ld] [@x%lx] GET bn=0x%lx xae=0x%lx xa_index=0x%lx xa_offset=0x%x\n",
			   inode->i_ino, pi->start + pi->cached, bn, (ulong)xae, xas.xa_index, xas.xa_offset);

		pi->bns[pi->cached++] = bn;
		if (pi->cached == pi->requested)
			break; /* ALL DONE */
	}

	rcu_read_unlock();
}
<pi.c>

Thank you for looking, good day
Boaz

