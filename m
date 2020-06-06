Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E271F06EA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 16:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgFFOOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 10:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFFON7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:13:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E68C03E96A;
        Sat,  6 Jun 2020 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kZFFIQSCr7yyXptlP99I5MEUyyxcK9BDprGW6uwLGyw=; b=LnpXu7kZgPy1Zjdlo2ayq4t9Ol
        e+MYIvXoXhoLfaDGnk3sKqYrWgoWGm0Zv9AfLuPVPd1njCjG463JPLPRBBL5ySvi8tekidrh899fO
        OYZonwTuV9eWc16sQKjfj2VzXwnXugbaL8GDF7pLFz4EVCoBJwTKTe6pNJjxxWAXQ1DRREWtH6MF5
        lXSJ10WjqEgRyB9Xcd3inoRdQxxik03DOZDKZ70zrEjHkFg0SPcsT91F0tV6S15marSUJ1sSPviFd
        NQ2mNHYD3jPZeCcMsQkPlrEqXrhgyD5JpmQHcvQK5/4J9UR0qzVX2HU4sg+mtTm6wGQWLrwLEtSMB
        zsgWWMHg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhZZy-0002Nq-2W; Sat, 06 Jun 2020 14:13:46 +0000
Date:   Sat, 6 Jun 2020 07:13:45 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 2/3] fs: Introduce cmdline argument exceed_file_max_panic
Message-ID: <20200606141345.GN19604@bombadil.infradead.org>
References: <1591425140-20613-1-git-send-email-yangtiezhu@loongson.cn>
 <1591425140-20613-2-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591425140-20613-2-git-send-email-yangtiezhu@loongson.cn>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 06, 2020 at 02:32:19PM +0800, Tiezhu Yang wrote:
> It is important to ensure that files that are opened always get closed.
> Failing to close files can result in file descriptor leaks. One common
> answer to this problem is to just raise the limit of open file handles
> and then restart the server every day or every few hours, this is not
> a good idea for long-lived servers if there is no leaks.
> 
> If there exists file descriptor leaks, when file-max limit reached, we
> can see that the system can not work well and at worst the user can do
> nothing, it is even impossible to execute reboot command due to too many
> open files in system. In order to reboot automatically to recover to the
> normal status, introduce a new cmdline argument exceed_file_max_panic for
> user to control whether to call panic in this case.

ulimit -n is your friend.
