Return-Path: <linux-fsdevel+bounces-39384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFF6A1343C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 08:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9833A5B7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 07:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C25193402;
	Thu, 16 Jan 2025 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIG6AcyD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82125155308;
	Thu, 16 Jan 2025 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737013622; cv=none; b=X5gCVAQ5jHFjvQjm87opST2r/jUi5BXf97KPUvYMRs6yhUKYGUph+p5h9to+bUbyRvHhehdbSP8gerfLvm9+E25E43wHsYrV0pD81f4IK1Ggq96kSG4lfMHBYdhGJuRlGK7c4XXVen0diim6X7578Cs8GevA16kYW8ZYai1fjmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737013622; c=relaxed/simple;
	bh=6jc/4XZGbTqsyHEnNXoRRedmH5dITZXCxwhsGog1iJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVo+V++iox8wtBUDHfON3AaZlu5U3EzxzGsCyw/pwVLAVNj32j9h5YWCxBJ7IHp1Qj1KYfd2nRBDaUBd55vlkaSNqBEfkaifWs3r3bm/i7JLSQkZthISvVqtp/9sKSlepKK1D2VmzLHe5hrxHDmh6nTc1ro0GKGOVm5pGqBp2HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIG6AcyD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so318579f8f.0;
        Wed, 15 Jan 2025 23:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737013619; x=1737618419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lOwwdUb1gni4wsiR/ycKXrk2XkgbcjkCvOfjLWEjA8A=;
        b=lIG6AcyDQ3VN0S34tSr9h7loHLbJEydY9REq50FXhMF1KmXRhu60qpVjr2Hs6/z+Qx
         +Iu31g+MWUC9Da4TtgTXwGr5N7xfJaID6r3WKR1b2ufdo5y1AoCFXrDFZefEZLF4WfoV
         zQz7AxbbiXL8LTuBiWTinjznLv7k+cDF6HhJvt/z4k06PAQKokGTjAkGaczJPUc99jTF
         2V7hB8Ux3ggM4tsJMdH/5Z3XtMTL38ajxiamd1Fu3xWNcMySUXzX5wzpEwMFBCw12kKG
         rAOFeJKlxLU7db/VtbI5NJDdF5yZxhZu5kDENhQaZbkoaKfxrA3FM/wVLmh3LcwXMNZI
         rO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737013619; x=1737618419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOwwdUb1gni4wsiR/ycKXrk2XkgbcjkCvOfjLWEjA8A=;
        b=MV3aVR/Ag/wmaTz0cRM+MeeyWxErckeAPCPxmm30R13bP04E/9zCKxzdAoAqNu5OOX
         eahRFzpKGm2IFjtFyuC9+oD+uDSVAqYF2UP//Ufq4XIQOUVl12GYpqB6DGtt9/3BXPWZ
         4vp6t/Ue6KM7irH3pwHw4bgpE0s/HMxPgIApXX+I9SWHQLjJwN1Yl43A496tJINaUkLz
         XyPauyTAvJmaJzEJhWopwwo1FMQlFlsGHMyNpnzV7lIRWgyoNU5Kk0Lah9xxL366RQoU
         ZxZikF9Bj3uTDZQN4sTUTRC0TuAp+hfBVOcEw/jXWoEb0MJO+0FOZcBpRZKWXyxcouhq
         XurQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmbKWEJnrYqMigXRxawN9FAt18ZDrQ9n/WFLUmLHQ13T9rGrZfeglnLPsXxXj2BvbaNQiIF+T45BCfgTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2WpgXJAHAvHt+385FVKicPQsXP/nFcqlNO7KKVbkP1oV00tGX
	99fQsbTmFJxkhjyZhzuMHommjx4++aY3xHOemyAnybkb6KxXGoB+
X-Gm-Gg: ASbGnctCYhEG47DDNO0SLBrafZAS5sZVUf2QUZN9PXIC7g/7fmRbYOYACUvXj4HRp0W
	UPByws51GB/yosyApv4xbtcB9qsA5gLy3E+enA4/3iS2qqc+yOrfFgzafLylFkcvzzHGN2kFjAg
	nnKWZ6M6Hvc7UVvQVYy7FOS5YOUmj339ikPOtgVySOM9NaYnmflS/rBIdeieknQDIK3lE+K5Yqv
	vH7w4K9l2tKtCi68T/e/6aSu91TtvdlvRboBtofT9opclf/qAFHR2cYgMGBLUMm1yB/eyL8
X-Google-Smtp-Source: AGHT+IGQpux8rCt6KFx7D+p++3UwOtan1yy1p9iE+n3f++1z5EWVFeAaOLQKDKSmwrw/+5UvM/GCuw==
X-Received: by 2002:a05:6000:1788:b0:386:3d27:b4f0 with SMTP id ffacd0b85a97d-38bec505c43mr1305219f8f.14.1737013618619;
        Wed, 15 Jan 2025 23:46:58 -0800 (PST)
Received: from f (cst-prg-69-191.cust.vodafone.cz. [46.135.69.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74c4751sm49392175e9.19.2025.01.15.23.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 23:46:57 -0800 (PST)
Date: Thu, 16 Jan 2025 08:46:48 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Tavian Barnes <tavianator@tavianator.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump: allow interrupting dumps of large anonymous
 regions
Message-ID: <t2cucclkkxj65fk7nknzogbeobyq7tgx4klep77ptnnlfrv34e@vjkzxymgnr4r>
References: <049f0da40ed76d94c419f83dd42deb413d6afb44.1737000287.git.tavianator@tavianator.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <049f0da40ed76d94c419f83dd42deb413d6afb44.1737000287.git.tavianator@tavianator.com>

On Wed, Jan 15, 2025 at 11:05:38PM -0500, Tavian Barnes wrote:
> dump_user_range() supports sparse core dumps by skipping anonymous pages
> which have not been modified.  If get_dump_page() returns NULL, the page
> is skipped rather than written to the core dump with dump_emit_page().
> 
> Sadly, dump_emit_page() contains the only check for dump_interrupted(),
> so when dumping a very large sparse region, the core dump becomes
> effectively uninterruptible.  This can be observed with the following
> test program:
> 
>     #include <stdlib.h>
>     #include <stdio.h>
>     #include <sys/mman.h>
> 
>     int main(void) {
>         char *mem = mmap(NULL, 1ULL << 40, PROT_READ | PROT_WRITE,
>                 MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE, -1, 0);
>         printf("%p %m\n", mem);
>         if (mem != MAP_FAILED) {
>                 mem[0] = 1;
>         }
>         abort();
>     }
> 
> The program allocates 1 TiB of anonymous memory, touches one page of it,
> and aborts.  During the core dump, SIGKILL has no effect.  It takes
> about 30 seconds to finish the dump, burning 100% CPU.
> 

While the patch makes sense to me, this should not be taking anywhere
near this much time and plausibly after unscrewing it will stop being a
factor.

So I had a look with a profiler:
-   99.89%     0.00%  a.out
     entry_SYSCALL_64_after_hwframe                      
     do_syscall_64                                       
     syscall_exit_to_user_mode                           
     arch_do_signal_or_restart                           
   - get_signal                                          
      - 99.89% do_coredump                               
         - 99.88% elf_core_dump                          
            - dump_user_range                            
               - 98.12% get_dump_page                    
                  - 64.19% __get_user_pages              
                     - 40.92% gup_vma_lookup             
                        - find_vma                       
                           - mt_find                     
                                4.21% __rcu_read_lock    
                                1.33% __rcu_read_unlock  
                     - 3.14% check_vma_flags             
                          0.68% vma_is_secretmem         
                       0.61% __cond_resched              
                       0.60% vma_pgtable_walk_end        
                       0.59% vma_pgtable_walk_begin      
                       0.58% no_page_table               
                  - 15.13% down_read_killable            
                       0.69% __cond_resched              
                    13.84% up_read                       
                 0.58% __cond_resched                    


Almost 29% of time is spent relocking the mmap semaphore in
__get_user_pages. This most likely can operate locklessly in the fast
path. Even if somehow not, chances are the lock can be held across
multiple calls.

mt_find spends most of it's time issuing a rep stos of 48 bytes (would
be faster to rep mov 6 times instead). This is the compiler being nasty,
I'll maybe look into it.

However, I strongly suspect the current iteration method is just slow
due to repeat mt_find calls and The Right Approach(tm) would make this
entire thing finish within miliseconds by iterating the maple tree
instead, but then the mm folk would have to be consulted on how to
approach this and it may be time consuming to implement.

Sorting out relocking should be an easily achievable & measurable win
(no interest on my end).

