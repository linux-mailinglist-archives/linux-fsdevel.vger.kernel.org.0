Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB27C65F9C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 03:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjAFC7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 21:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjAFC7M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 21:59:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31E534D6E;
        Thu,  5 Jan 2023 18:59:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3131661BE9;
        Fri,  6 Jan 2023 02:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D088C433D2;
        Fri,  6 Jan 2023 02:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1672973950;
        bh=9iIG1jjU+cVTa0DXtA/OdBSV7ZjX8LTbLAr0Q7d3PZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bz2w4rhzobDqBZ+3D9oM3QCJuycDcgpASYh8SwLG6eDAMHrwgtlykxcUYfTZNa89D
         AQilsK0RNFrUl70fxFHUSBDmB4mR4PiUJ3Nr61ej0hz59AvWqMoLPdXQbcXFAEfnnv
         AJ3D4yZM1WVhHKgliO3uqnMA8s/Rwcxc10RGlHSA=
Date:   Thu, 5 Jan 2023 18:59:09 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pipe: use __pipe_{lock,unlock} instead of spinlock
Message-Id: <20230105185909.c77ce4d136279ec46a204d61@linux-foundation.org>
In-Reply-To: <20230103063303.23345-1-zhanghongchen@loongson.cn>
References: <20230103063303.23345-1-zhanghongchen@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue,  3 Jan 2023 14:33:03 +0800 Hongchen Zhang <zhanghongchen@loongson.cn> wrote:

> Use spinlock in pipe_read/write cost too much time,IMO
> pipe->{head,tail} can be protected by __pipe_{lock,unlock}.
> On the other hand, we can use __pipe_lock/unlock to protect the
> pipe->head/tail in pipe_resize_ring and post_one_notification.

Can you please test this with the test code in Linus's 0ddad21d3e99 and
check that performance is good?

