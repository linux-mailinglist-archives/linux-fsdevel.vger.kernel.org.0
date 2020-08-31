Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1765257F68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 19:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgHaRQz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 13:16:55 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:33968 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgHaRQz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:16:55 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 5471F1B44DF;
        Tue,  1 Sep 2020 02:16:54 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 07VHGr4D366255
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 1 Sep 2020 02:16:54 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 07VHGquF3463679
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 1 Sep 2020 02:16:52 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 07VHGqsu3463678;
        Tue, 1 Sep 2020 02:16:52 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fat: Avoid oops when bdi->io_pages==0
References: <87ft85osn6.fsf@mail.parknet.co.jp>
        <b4e1f741-989c-6c9d-b559-4c1ada88c499@kernel.dk>
        <87o8mq6aao.fsf@mail.parknet.co.jp>
        <4010690f-20ad-f7ba-b595-2e07b0fa2d94@kernel.dk>
Date:   Tue, 01 Sep 2020 02:16:52 +0900
In-Reply-To: <4010690f-20ad-f7ba-b595-2e07b0fa2d94@kernel.dk> (Jens Axboe's
        message of "Mon, 31 Aug 2020 10:39:26 -0600")
Message-ID: <87h7si68hn.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 8/31/20 10:37 AM, OGAWA Hirofumi wrote:
>> Jens Axboe <axboe@kernel.dk> writes:
>> 
>>> I don't think we should work-around this here. What device is this on?
>>> Something like the below may help.
>> 
>> The reported bug is from nvme stack, and the below patch (I submitted
>> same patch to you) fixed the reported case though. But I didn't verify
>> all possible path, so I'd liked to use safer side.
>> 
>> If block layer can guarantee io_pages!=0 instead, and can apply to
>> stable branch (5.8+). It would work too.
>
> We really should ensure that ->io_pages is always set, imho, instead of
> having to work-around it in other spots.

I think it is good too. However, the issue would be how to do it for
stable branch.

If you think that block layer patch is enough and submit to stable
(5.8+) branch instead, I'm fine without fatfs patch. (Or removing
workaround in fatfs with block layer patch later?)

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
