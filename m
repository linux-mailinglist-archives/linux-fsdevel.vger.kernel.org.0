Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9903A2E32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 16:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhFJOcA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 10:32:00 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:10966 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhFJOb7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1623335404; x=1654871404;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Gb5TZShs2o7U2AFWd9kwifVoMA/w7WqcFdf1z4TiWao=;
  b=Z47fgTTC9wF6soWmdDKsR/MtcAVMNYr+dmNuwV+oBqzzZs4qlySOZ0fo
   9P9/6h/DguLyKX4nGsC1owwHuqwXiMpbTTNijUoYJy77VJ/UZ9QS4M/8V
   AgswNFvd9l87LUICk5+zfBzjwJKSeBmRrXhhgEOJR2kJSj319v+qkUVgK
   U=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 10 Jun 2021 07:30:03 -0700
X-QCInternal: smtphost
Received: from nalasexr03e.na.qualcomm.com ([10.49.195.114])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 Jun 2021 07:30:02 -0700
Received: from [10.111.162.47] (10.80.80.8) by nalasexr03e.na.qualcomm.com
 (10.49.195.114) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 10 Jun
 2021 07:30:00 -0700
Subject: Re: [RFC][PATCHSET] iov_iter work
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <7433441f-b175-8484-240c-d1498c8c43f2@quicinc.com>
Date:   Thu, 10 Jun 2021 10:29:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03c.na.qualcomm.com (10.85.0.106) To
 nalasexr03e.na.qualcomm.com (10.49.195.114)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/6/2021 3:07 PM, Al Viro wrote:
> 	Large part of the problems with iov_iter comes from its history -
> it was not designed, it accreted over years.  Worse, its users sit on
> rather hots paths, so touching any of the primitives can come with
> considerable performance cost.

Al, a quick fuzzing on today's linux-next triggered this. I never saw this before, so I am wondering if this is anything to do with this series. I could try to narrow it down and bisect if necessary. Any thoughts?

[ 1904.633865][T14444] BUG: KASAN: stack-out-of-bounds in iov_iter_revert+0x65c/0x760
[ 1904.641445][T14444] Read of size 8 at addr ffff80002692faf8 by task trinity-c30/14444
[ 1904.649275][T14444]
[ 1904.651461][T14444] CPU: 28 PID: 14444 Comm: trinity-c30 Not tainted 5.13.0-rc5-next-20210610+ #24
[ 1904.660419][T14444] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
[ 1904.668944][T14444] Call trace:
[ 1904.672084][T14444]  dump_backtrace+0x0/0x3b8
[ 1904.676445][T14444]  show_stack+0x20/0x30
[ 1904.680454][T14444]  dump_stack_lvl+0x144/0x190
[ 1904.684987][T14444]  print_address_description.constprop.0+0xd0/0x3c8
[ 1904.691432][T14444]  kasan_report+0x1f0/0x208
[ 1904.695787][T14444]  __asan_report_load8_noabort+0x34/0x60
[ 1904.701274][T14444]  iov_iter_revert+0x65c/0x760
iov_iter_revert at /usr/src/linux-next/lib/iov_iter.c:1118
(inlined by) iov_iter_revert at /usr/src/linux-next/lib/iov_iter.c:1058
[ 1904.705891][T14444]  netlink_sendmsg+0x870/0xa18
netlink_sendmsg at /usr/src/linux-next/net/netlink/af_netlink.c:1913
[ 1904.710511][T14444]  sock_write_iter+0x208/0x358
sock_sendmsg_nosec at /usr/src/linux-next/net/socket.c:657
(inlined by) sock_sendmsg at /usr/src/linux-next/net/socket.c:674
(inlined by) sock_write_iter at /usr/src/linux-next/net/socket.c:1001
[ 1904.715128][T14444]  do_iter_readv_writev+0x2e8/0x598
[ 1904.720180][T14444]  do_iter_write+0x110/0x4d0
[ 1904.724622][T14444]  vfs_writev+0x120/0xa00
[ 1904.728805][T14444]  do_writev+0x1a0/0x1e8
[ 1904.732900][T14444]  __arm64_sys_writev+0x78/0xa8
[ 1904.737604][T14444]  invoke_syscall.constprop.0+0xdc/0x1d8
[ 1904.743091][T14444]  do_el0_svc+0xe4/0x298
[ 1904.747187][T14444]  el0_svc+0x20/0x30
[ 1904.750934][T14444]  el0t_64_sync_handler+0xb0/0xb8
[ 1904.755811][T14444]  el0t_64_sync+0x178/0x17c
[ 1904.760168][T14444]
[ 1904.762352][T14444]
[ 1904.764533][T14444] addr ffff80002692faf8 is located in stack of task trinity-c30/14444 at offset 152 in frame:
[ 1904.774617][T14444]  vfs_writev+0x8/0xa00
[ 1904.778629][T14444]
[ 1904.780810][T14444] this frame has 3 objects:
[ 1904.785164][T14444]  [48, 56) 'iov'
[ 1904.785171][T14444]  [80, 120) 'iter'
[ 1904.788656][T14444]  [160, 288) 'iovstack'
[ 1904.792315][T14444]
[ 1904.798582][T14444] Memory state around the buggy address:
[ 1904.804065][T14444]  ffff80002692f980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1904.811979][T14444]  ffff80002692fa00: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
[ 1904.819892][T14444] >ffff80002692fa80: 00 00 00 f2 f2 f2 00 00 00 00 00 f2 f2 f2 f2 f2
[ 1904.827806][T14444]                                                                 ^
[ 1904.835638][T14444]  ffff80002692fb00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1904.843554][T14444]  ffff80002692fb80: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
