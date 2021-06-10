Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3C83A30CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 18:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhFJQkL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 12:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhFJQkL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:40:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F22DF613DD;
        Thu, 10 Jun 2021 16:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623343094;
        bh=w5FS7msZd53QGrzynQ2zBByBKIafgWaaWS2kEfVoRaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sn+pZJGG22aPYvg/zaT3ygY3GYmzI+DhqBV3VljBQqLVnjLEl1U2N6pIO/A1/M5xx
         k4jnPZxr3yk6kyZSV+eAP5ofYiPYXwFnrtiwUw9HmJQblGnC4POUoU1O6W3pIW1rpS
         9da7659MY95Yb/CULLizDh4/jhvDqdAUuOFJOb+ek5jftgPepcFQeq+owsDfzt0p5K
         +2kmf27gBfhyMrqeKbaMTvW4Nj5M2ebI9CkE3VBLudA7j4A4ZczZCniyBWxAYT+ofG
         nTS7VL1Pby9bqWgHHPu/3sgr85TblywNyryLb+O2Lz6rsi38DSj5bv5nFSR09agAxw
         dFPMZa+MOSJ6A==
Date:   Fri, 11 Jun 2021 01:38:08 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Tim Walker <tim.t.walker@seagate.com>
Cc:     Ric Wheeler <ricwheeler@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Matthew Wilcox <willy@infradead.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] durability vs performance for flash devices
 (especially embedded!)
Message-ID: <20210610163808.GA26360@redsun51.ssa.fujisawa.hgst.com>
References: <55d3434d-6837-3a56-32b7-7354e73eb258@gmail.com>
 <0e1ed05f-4e83-7c84-dee6-ac0160be8f5c@acm.org>
 <YMEItMNXG2bHgJE+@casper.infradead.org>
 <e9eaf87d-5c04-8974-4f0f-0fc9bac9a3b1@acm.org>
 <e191c791-4646-bf47-0435-5b0d665eca89@gmail.com>
 <45A42D25-FB2A-43EB-8123-9F7B25590018@seagate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A42D25-FB2A-43EB-8123-9F7B25590018@seagate.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 10, 2021 at 11:07:09AM +0000, Tim Walker wrote:
>  Wednesday, June 9, 2021 at 9:20:52 PM Ric Wheeler wrote:
> >On 6/9/21 2:47 PM, Bart Van Assche wrote:
> >> On 6/9/21 11:30 AM, Matthew Wilcox wrote:
> >>> maybe you should read the paper.
> >>>
> >>> " Thiscomparison demonstrates that using F2FS, a flash-friendly file
> >>> sys-tem, does not mitigate the wear-out problem, except inasmuch asit
> >>> inadvertently rate limitsallI/O to the device"
> >> It seems like my email was not clear enough? What I tried to make clear
> >> is that I think that there is no way to solve the flash wear issue with
> >> the traditional block interface. I think that F2FS in combination with
> >> the zone interface is an effective solution.
> >>
> >> What is also relevant in this context is that the "Flash drive lifespan
> >> is a problem" paper was published in 2017. I think that the first
> >> commercial SSDs with a zone interface became available at a later time
> >> (summer of 2020?).
> >>
> >> Bart.
> >
> >Just to address the zone interface support, it unfortunately takes a very long 
> >time to make it down into the world of embedded parts (emmc is super common and 
> >very primitive for example). UFS parts are in higher end devices, have not had a 
> >chance to look at what they offer.
> >
> >Ric
> 
> For zoned block devices, particularly the sequential write zones,
> maybe it makes more sense for the device to manage wear leveling on a
> zone-by-zone basis. It seems like it could be pretty easy for a device
> to decide which head/die to select for a given zone when the zone is
> initially opened after the last reset write pointer.

I think device managed wear leveling was the point of zoned ssd's. If the
host was managing that, then that's pretty much an open channel ssd.
