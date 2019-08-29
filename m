Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 303F6A11AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 08:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfH2GWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 02:22:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34312 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfH2GWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 02:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3JI7QotK2O20Md1eCkQSEHO4eOFyIfeK4uIFkYS8zQI=; b=O9yzkvqP60gDvRWGFRg1iYPukL
        DTswgHAsoTTZs2abhMX4SVtYr5V06YCD343I+LjhwegBYsWC4iVvh7ge3kMySB4w+A2ewqZUXiF9p
        +TaW+scgxAa5FgCPV966HbQ35APontkN4YwUN2EURzO/b9p7iGSwnnq3c6SCY4wNQ9dyFoNB12wHo
        Pjm2/Rcj16CLyuxOj5iM0Tisd9jGabkJTTv/fH7eRyrjrdkCsERr799lY5yoztovwNxNFWAK4aLxq
        UGqkACxUkTTp/w/6SL1AOZpncM/xnUVNP5VW5JZjTBxPCHbava+C3BdaLHIrBj1RIfDxkQRecRD8n
        MLKb2Vqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3Dom-0002AM-IS; Thu, 29 Aug 2019 06:22:00 +0000
Date:   Wed, 28 Aug 2019 23:22:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Neuling <mikey@neuling.org>,
        David Hildenbrand <david@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Breno Leitao <leitao@debian.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 1/4] fs: always build llseek.
Message-ID: <20190829062200.GA3047@infradead.org>
References: <cover.1566936688.git.msuchanek@suse.de>
 <80b1955b86fb81e4642881d498068b5a540ef029.1566936688.git.msuchanek@suse.de>
 <20190828151552.GA16855@infradead.org>
 <20190828181540.21fa33a4@naga>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190828181540.21fa33a4@naga>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 28, 2019 at 06:15:40PM +0200, Michal Suchánek wrote:
> On Wed, 28 Aug 2019 08:15:52 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Tue, Aug 27, 2019 at 10:21:06PM +0200, Michal Suchanek wrote:
> > > 64bit !COMPAT does not build because the llseek syscall is in the tables.  
> > 
> > Well, this will bloat thinkgs like 64-bit RISC-V for no good reason.
> > Please introduce a WANT_LSEEK like symbol that ppc64 can select instead.
> 
> It also builds when llseek is marked as 32bit only in syscall.tbl
> 
> It seems it was handled specially in some way before syscall.tbl was
> added, though (removed in ab66dcc76d6ab8fae9d69d149ae38c42605e7fc5)

Independ of if you need it on a purely 64-bit build on powerpc (which
I'll let the experts figure out) it is not needed on a purely 64-bit
build on other platforms.  So please make sure it is still built
conditional, just possibly with an opt-in for powerpc.
