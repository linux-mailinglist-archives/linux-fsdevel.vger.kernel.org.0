Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E75E21B5A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 14:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgGJM6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 08:58:23 -0400
Received: from verein.lst.de ([213.95.11.211]:43198 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgGJM6R (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:58:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E96EB68AEF; Fri, 10 Jul 2020 14:58:13 +0200 (CEST)
Date:   Fri, 10 Jul 2020 14:58:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 15/23] seq_file: switch over direct seq_read method
 calls to seq_read_iter
Message-ID: <20200710125813.GA8246@lst.de>
References: <20200707174801.4162712-1-hch@lst.de> <20200707174801.4162712-16-hch@lst.de> <5a2a97f1-58b5-8068-3c69-bb06130ffb35@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a2a97f1-58b5-8068-3c69-bb06130ffb35@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 10, 2020 at 01:55:29PM +0100, Jon Hunter wrote:
> Following this change, I have noticed that several debugfs entries can
> no longer be read on some Tegra platforms. For example ...
> 
> $ sudo cat /sys/kernel/debug/usb/xhci/3530000.usb/event-ring/cycle
> cat: /sys/kernel/debug/usb/xhci/3530000.usb/event-ring/cycle: Invalid
> argument
> 
> $ sudo cat /sys/kernel/debug/emc/available_rates
> 
> 
> cat: /sys/kernel/debug/emc/available_rates: Invalid argument
> 
> $ sudo cat /sys/kernel/debug/bpmp/debug/proc/testint
> cat: /sys/kernel/debug/bpmp/debug/proc/testint: Invalid argument
> 
> $ sudo cat /sys/kernel/debug/pcie/ports
> 
> 
> cat: /sys/kernel/debug/pcie/ports: Invalid argument
> 
> I have reverted the above drivers to use seq_read() instead of
> seq_read_iter() and they work again. Have you seen any problems with this?

I haven't seen any of that.  But some of these files should also
exist on x86, so let me try to reproduce it.
