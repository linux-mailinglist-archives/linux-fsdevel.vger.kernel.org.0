Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0136C6736D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 18:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfGLQg2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 12:36:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfGLQg2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 12:36:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E5CE88E55;
        Fri, 12 Jul 2019 16:36:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2F4BD600CD;
        Fri, 12 Jul 2019 16:36:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 12 Jul 2019 18:36:28 +0200 (CEST)
Date:   Fri, 12 Jul 2019 18:36:26 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Alexey Izbyshev <izbyshev@ispras.ru>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        security@kernel.org
Subject: Re: [PATCH] proc: Fix uninitialized byte read in get_mm_cmdline()
Message-ID: <20190712163625.GF21989@redhat.com>
References: <20190712160913.17727-1-izbyshev@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712160913.17727-1-izbyshev@ispras.ru>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 12 Jul 2019 16:36:28 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/12, Alexey Izbyshev wrote:
>
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -275,6 +275,8 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
>  		if (got <= offset)
>  			break;
>  		got -= offset;
> +		if (got < size)
> +			size = got;

Acked-by: Oleg Nesterov <oleg@redhat.com>

