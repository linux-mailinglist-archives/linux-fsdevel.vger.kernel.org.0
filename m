Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B03EB131640
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 17:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgAFQm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 11:42:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37804 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFQm6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Y60hMYCeWYx1RgJjYe/0Uw9RlJWWRdvmgf8je/CcB+o=; b=Iq4YQ4+Jiaqn5IL9nyQWU6gA/a
        G0i5aC7YZwecat+vNIJsyJNpFBctgTcmaCNUlrV+IMBgvXNy2XYapf6Nmm5zLWPobbUvxdX2hdvTS
        KzMCr1F8j0SlUhfB5tgPdeNLVPGre6LlMObDzuYmLlk7rUu1OdmrUmFa2mfN21NrMZhai1T+If9mR
        Vi477L1yV90RO8CXOaX6Z9wv2ImXTi9mmpK7N6FEDoLwyV+wDBNG2D13BD/C9Q1IRTZszQRI83THq
        iSkt13z9XLDUrjDpA5yx3GkVYGRUPrVujHzdEDhHwYRFKdS7qkz2Hlujh9HpzpVH+ZRsj8+K3+NoB
        jh6830Ew==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ioVSz-0003mO-8J; Mon, 06 Jan 2020 16:42:57 +0000
Date:   Mon, 6 Jan 2020 08:42:57 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Sitsofe Wheeler <sitsofe@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, drh@sqlite.org,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        harshad shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: Questions about filesystems from SQLite author presentation
Message-ID: <20200106164257.GJ6788@bombadil.infradead.org>
References: <CALjAwxi3ZpRZLS9QaGfAqwAVST0Biyj_p-b22f=iq_ns4ZQyiA@mail.gmail.com>
 <CAOQ4uxhJhzUj_sjhDknGzdLs6kOXzt3GO2vyCzmuBNTSsAQLGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhJhzUj_sjhDknGzdLs6kOXzt3GO2vyCzmuBNTSsAQLGA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 06, 2020 at 05:40:20PM +0200, Amir Goldstein wrote:
> On Mon, Jan 6, 2020 at 9:26 AM Sitsofe Wheeler <sitsofe@gmail.com> wrote:
> > If a write occurs on one or two bytes of a file at about the same time as a power
> > loss, are other bytes of the file guaranteed to be unchanged after reboot?
> > Or might some other bytes within the same sector have been modified as well?
> 
> I don't see how other bytes could change in this scenario, but I don't
> know if the
> hardware provides this guarantee. Maybe someone else knows the answer.

The question is nonsense because there is no way to write less than one
sector to a hardware device, by definition.  So, treating this question
as being a read-modify-write of a single sector (assuming the "two bytes"
don't cross a sector boundary):

Hardware vendors are reluctant to provide this guarantee, but it's
essential to constructing a reliable storage system.  We wrote the NVMe
spec in such a way that vendors must provide single-sector-atomicity
guarantees, and I hope they haven't managed to wiggle some nonsense
into the spec that allows them to not make that guarantee.  The below
is a quote from the 1.4 spec.  For those not versed in NVMe spec-ese,
"0's based value" means that putting a zero in this field means the
value of AWUPF is 1.

  Atomic Write Unit Power Fail (AWUPF): This field indicates the size of
  the write operation guaranteed to be written atomically to the NVM across
  all namespaces with any supported namespace format during a power fail
  or error condition.

  If a specific namespace guarantees a larger size than is reported in
  this field, then this namespace specific size is reported in the NAWUPF
  field in the Identify Namespace data structure. Refer to section 6.4.

  This field is specified in logical blocks and is a 0’s based value. The
  AWUPF value shall be less than or equal to the AWUN value.

  If a write command is submitted with size less than or equal to the
  AWUPF value, the host is guaranteed that the write is atomic to the
  NVM with respect to other read or write commands. If a write command
  is submitted that is greater than this size, there is no guarantee of
  command atomicity. If the write size is less than or equal to the AWUPF
  value and the write command fails, then subsequent read commands for the
  associated logical blocks shall return data from the previous successful
  write command. If a write command is submitted with size greater than
  the AWUPF value, then there is no guarantee of data returned on
  subsequent reads of the associated logical blocks.

I take neither blame nor credit for what other storage standards may
implement; this is the only one I had a hand in, and I had to fight
hard to get it.
