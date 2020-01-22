Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38BE91449C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 03:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgAVCZi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 21:25:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44410 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgAVCZi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 21:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9ZOGsttRmOTfzjL1ECAYcpfTSZoQqHHRoblxH4x0j4M=; b=XhszVteo70FgyKJG9DtA7o+hV
        lGwkANDHq2wJhjn1MqGcqwTJUma+irli294AufHU/9wJByJWODQdSMqejTOSp7RhswG4C+IA43k1S
        n09gLgOqssnByXkE/bCGX/JzPVZsdlMUPKHehIk88YKYk4VXLYMdJyxJwOE2zjMK15HrO0MeKnpLP
        R+ZH2c8rygQO5+8BKLrSfTwDNDrSlx35LEV6aBqhpnDwMSq93IYl/wDvEvmsBvo0kQ94ttkqvnI64
        xqMCl2/SxHizEC8XYpRFJLxl9ufloOdrpXp3/aypAorvYDZGa7ybSY5N6rtXqrTT8zNwI+0rslWc4
        tU4Da/UJg==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iu5i4-0001Bw-5r; Wed, 22 Jan 2020 02:25:36 +0000
Subject: Re: mmotm 2020-01-21-13-28 uploaded (convert everything to struct
 proc_ops)
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
References: <20200121212915.APuBK%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5a81ab98-4f02-f415-4da5-3d5685915a0e@infradead.org>
Date:   Tue, 21 Jan 2020 18:25:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200121212915.APuBK%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/21/20 1:29 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2020-01-21-13-28 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.

NULL seems to be misspelled as NUL in the proc-convert-everything-to-struct-proc_ops.patch
patch for kernel/sched/psi.c:

 static int __init psi_proc_init(void)
 {
 	if (psi_enable) {
 		proc_mkdir("pressure", NULL);
-		proc_create("pressure/io", 0, NULL, &psi_io_fops);
-		proc_create("pressure/memory", 0, NULL, &psi_memory_fops);
-		proc_create("pressure/cpu", 0, NULL, &psi_cpu_fops);
+		proc_create("pressure/io", 0, NULL, &psi_io_proc_ops);
+		proc_create("pressure/memory", 0, NUL, &psi_memory_proc_ops); <<<<<<<<<<
+		proc_create("pressure/cpu", 0, NULL &psi_cpu_proc_ops);

also missing a comma above...

 	}
 	return 0;


../kernel/sched/psi.c: In function ‘psi_proc_init’:
../kernel/sched/psi.c:1286:37: error: ‘NUL’ undeclared (first use in this function); did you mean ‘_UL’?
   proc_create("pressure/memory", 0, NUL, &psi_memory_proc_ops);
                                     ^~~
                                     _UL
../kernel/sched/psi.c:1286:37: note: each undeclared identifier is reported only once for each function it appears in
../kernel/sched/psi.c:1287:39: error: invalid operands to binary & (have ‘void *’ and ‘const struct proc_ops’)
   proc_create("pressure/cpu", 0, NULL &psi_cpu_proc_ops);
                                       ^
../kernel/sched/psi.c:1287:3: error: too few arguments to function ‘proc_create’
   proc_create("pressure/cpu", 0, NULL &psi_cpu_proc_ops);
   ^~~~~~~~~~~
In file included from ../kernel/sched/psi.c:133:0:
../include/linux/proc_fs.h:64:24: note: declared here
 struct proc_dir_entry *proc_create(const char *name, umode_t mode, struct proc_dir_entry *parent, const struct proc_ops *proc_ops);
                        ^~~~~~~~~~~


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
