Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2226F456737
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 02:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhKSBHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 20:07:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233866AbhKSBHa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 20:07:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8882610E9;
        Fri, 19 Nov 2021 01:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637283869;
        bh=d+jScWzSF+d1/BExI5Xo0llKnxV+zdz/xcXpB+YM/BE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nCAdhKb+EeTQ6E9hx89/ge6Ru1IOPb55oNsdsIuC1Qhsy1ldI+Gl7qJgU53CzvOWR
         xXo/Q05D+by5aiZ3efc4u47rjymaB8SWjh3FLMLEW73MJ8YnmmeJd5EPjLzj4BjKMR
         oPWahSBY9lXH8h/4E6LNODzRNpgd8mkUv01qo0EA=
Date:   Thu, 18 Nov 2021 17:04:26 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: mmotm 2021-11-18-15-47 uploaded (<linux/proc_fs.h>)
Message-Id: <20211118170426.bfcd00c159aba815ffc282d3@linux-foundation.org>
In-Reply-To: <db0b9313-fef6-2977-9b1c-4c830edea5c5@infradead.org>
References: <20211118234743.-bgoWMQfK%akpm@linux-foundation.org>
        <db0b9313-fef6-2977-9b1c-4c830edea5c5@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 18 Nov 2021 16:53:30 -0800 Randy Dunlap <rdunlap@infradead.org> wrote:

> On 11/18/21 3:47 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2021-11-18-15-47 has been uploaded to
> > 
> >     https://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > https://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > https://ozlabs.org/~akpm/mmotm/series
> > 
> > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > followed by the base kernel version against which this patch series is to
> > be applied.
> 
> Hi,
> 
> I get hundreds of warnings from <linux/proc_fs.h>:
> 
> from proc-make-the-proc_create-stubs-static-inlines.patch:
> 
> ../include/linux/proc_fs.h:186:2: error: parameter name omitted
> ../include/linux/proc_fs.h:186:32: error: parameter name omitted
> ../include/linux/proc_fs.h:186:63: error: parameter name omitted

Nobody uses PROC_FS=n ;)

--- a/include/linux/proc_fs.h~proc-make-the-proc_create-stubs-static-inlines-fix
+++ a/include/linux/proc_fs.h
@@ -179,12 +179,14 @@ static inline struct proc_dir_entry *pro
 #define proc_create_single(name, mode, parent, show) ({NULL;})
 #define proc_create_single_data(name, mode, parent, show, data) ({NULL;})
 
-static inline struct proc_dir_entry *proc_create(
-	const char *, umode_t, struct proc_dir_entry *, const struct proc_ops *)
+static inline struct proc_dir_entry *
+proc_create(const char *name, umode_t mode, struct proc_dir_entry *parent,
+	    const struct proc_ops *proc_ops)
 { return NULL; }
 
-static inline struct proc_dir_entry *proc_create_data(
-	const char *, umode_t, struct proc_dir_entry *, const struct proc_ops *, void *)
+static inline struct proc_dir_entry *
+proc_create_data(const char *name, umode_t mode, struct proc_dir_entry *parent,
+		 const struct proc_ops *proc_ops, void *data)
 { return NULL; }
 
 static inline void proc_set_size(struct proc_dir_entry *de, loff_t size) {}
_

