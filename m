Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D6844EC05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 18:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhKLRgB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 12:36:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57910 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbhKLRf6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 12:35:58 -0500
Date:   Fri, 12 Nov 2021 18:33:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636738386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=kykZdLDhnOmjL+g6B46X7BTZ6Ur1JsgzvSbqdbNHrOs=;
        b=KVAKXpIt5B2iOlWAYuFfCy9Nlcem1ZEF1Zz5/01BXCBZUd2hZxltqBtvemBvWwWS1wpJ9M
        FPE7tUnI2VZ18JZu01Zbi4QPbMDF+fUe+ad2EnsxY6VbPz6PqzgiS4TVgDM49UiUe0MvTH
        MZtBDySnUuYlKQeoyXdPiolngia6PFcFyixwOIGJW6WhS03QY6PvKkQzq4roEDL5zoFzCl
        1cCUrdGlrcbcx2kIWc44M0mkS0xNGRcdR+qRabfTFtrqYyemfZCS8dCwrmbHKvStgzwu6d
        TriqGEeqzxgz6KRiJejX2zcLzXx5WPB+LG2Kl9GkevrxCnFkfrzRS7iGhSLfoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636738386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=kykZdLDhnOmjL+g6B46X7BTZ6Ur1JsgzvSbqdbNHrOs=;
        b=ezu7hZ0cAy3ONIHGUHbslTQ6O0QZIakZ42WGu3G/iqTV+3q0idBX5R9/9LTavK8UaE9NNU
        fSS32BfHXUNH5mBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: xas_retry() based loops on PREEMPT_RT.
Message-ID: <20211112173305.h36kodnm3awe3fn3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I've been looking at the xas_retry() based loops under PREEMPT_RT
constraints that is xarray::xa_lock owner got preempted by a task with
higher priority and this task is performing a xas_retry() based loop.
Since the xarray::xa_lock owner got preempted it can't make any progress
until the task the higher priority completes its task.

Based on my understanding this the XA_RETRY_ENTRY state is transient
while a node is removed from the tree. That is, it is first removed from
the tree, then set to XA_RETRY_ENTRY and then kfree()ed. Any RCU reader
that retrieved this node before it was removed, will see this flag and
will iterate the array from beginning at which point it won't see this
node again. 

The XA_ZERO_ENTRY flag is different as it is not transient. It should be
the responsibility of the reader not to start iterating the tree from
the beginning because this state won't change.
Most reader simply go to the next entry and I *assume* that for instance
mapping_get_entry() or find_get_entry() in mm/filemap.c won't see here
the XA_ZERO_ENTRY.

Is this correct?

Sebastian
