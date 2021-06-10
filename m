Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC873A33B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 21:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhFJTKU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 15:10:20 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:32214 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhFJTKU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1623352104; x=1654888104;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=WKtah1s5N0nQHR2zrg8vHuHf2WJcWUP5gtf2DlwFVFk=;
  b=xNN8wcM/7zTxJDKNodSJVKw2zAy2MZUvN7elDN+X/fGfZgLO7uUq8meL
   EqB8bH7W0EOa08/MGYcMLTFKRQB9uCEuBiRTkv+XnOobVj3M8q52oy9O9
   CRk+FAvaC6eKyv0hptIoUubiBRi2F4bsiahKX0uN2gVUeXnu3hYS4ZzZ7
   Y=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 10 Jun 2021 12:08:23 -0700
X-QCInternal: smtphost
Received: from nalasexr03e.na.qualcomm.com ([10.49.195.114])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 Jun 2021 12:08:22 -0700
Received: from [10.111.162.47] (10.80.80.8) by nalasexr03e.na.qualcomm.com
 (10.49.195.114) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 10 Jun
 2021 12:08:20 -0700
Subject: Re: [RFC][PATCHSET] iov_iter work
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <7433441f-b175-8484-240c-d1498c8c43f2@quicinc.com>
 <YMIxMszl0SoCmzcY@zeniv-ca.linux.org.uk>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <1337e3ea-6984-7f70-98cc-f20a43e659d2@quicinc.com>
Date:   Thu, 10 Jun 2021 15:08:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMIxMszl0SoCmzcY@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03b.na.qualcomm.com (10.85.0.98) To
 nalasexr03e.na.qualcomm.com (10.49.195.114)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/10/2021 11:35 AM, Al Viro wrote:
> On Thu, Jun 10, 2021 at 10:29:59AM -0400, Qian Cai wrote:
> 
>> Al, a quick fuzzing on today's linux-next triggered this. I never saw this before, so I am wondering if this is anything to do with this series. I could try to narrow it down and bisect if necessary. Any thoughts?
> 
> Do you have a reproducer?

I have no idea how reproducible this is, but it was triggered by running the fuzzing within a half-hour.

$ trinity -C 16

> call of memcpy_from_skb(), calling copy_from_iter_full(), which
> calls iov_iter_revert() on failure now...
> 
> Bloody hell.  Incremental, to be folded in:

This patch is running good so far. I'll report back if things changed.
