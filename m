Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5A12E7B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 23:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfE2VzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 17:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfE2VzW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 17:55:22 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CACB24249;
        Wed, 29 May 2019 21:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559166921;
        bh=OhogNqWyv3ABQbRFxsFTTaHIwV9toKCK+Od3Dfj5jco=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bolZTDocO64fe7H42Ji8mYAT9N3CDt0wz3HI2M0r11DOpSUexO2rezhKRrkdCZeGZ
         lIt7vsJCNrAeGKgI5ylwB0EL7ECXT1XhGQYxdzss0Inl3hUfpW2ME9A+iRONvQBJ3q
         cgCck4vZ79HohWvdKumiKIh/6fS+/FImiCQOcoGU=
Date:   Wed, 29 May 2019 14:55:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Jan Luebbe <jlu@pengutronix.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Lutomirski <luto@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHv2] fs/proc: allow reporting eip/esp for all coredumping
 threads
Message-Id: <20190529145520.c4b12290f48e46e23ac6d193@linux-foundation.org>
In-Reply-To: <87y32p7i7a.fsf@linutronix.de>
References: <20190522161614.628-1-jlu@pengutronix.de>
        <875zpzif8v.fsf@linutronix.de>
        <20190525143220.e771b7915d17f22dad1438fa@linux-foundation.org>
        <87d0k5f1g7.fsf@linutronix.de>
        <87y32p7i7a.fsf@linutronix.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 29 May 2019 10:55:53 +0200 John Ogness <john.ogness@linutronix.de> wrote:

> Commit 0a1eb2d474ed ("fs/proc: Stop reporting eip and esp in
> /proc/PID/stat") stopped reporting eip/esp and commit fd7d56270b52
> ("fs/proc: Report eip/esp in /prod/PID/stat for coredumping")
> reintroduced the feature to fix a regression with userspace core dump
> handlers (such as minicoredumper).
> 
> Because PF_DUMPCORE is only set for the primary thread, this didn't fix
> the original problem for secondary threads. Allow reporting the eip/esp
> for all threads by checking for PF_EXITING as well. This is set for all
> the other threads when they are killed. coredump_wait() waits for all
> the tasks to become inactive before proceeding to invoke the core the
> core dumper.
> 
> Reported-by: Jan Luebbe <jlu@pengutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  This is a rework of Jan's v1 patch that allows accessing eip/esp of all
>  the threads without risk of the task still executing on a CPU.

Jan's patch ended up including

Fixes: fd7d56270b526ca3 ("fs/proc: Report eip/esp in /prod/PID/stat for coredumping")
Cc: <stable@vger.kernel.org>

Are these not appropriate here?
