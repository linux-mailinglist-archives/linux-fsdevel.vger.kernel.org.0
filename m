Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E62CB1A08EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 10:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgDGIJ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 04:09:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45904 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgDGIJ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 04:09:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id o26so1329546pgc.12;
        Tue, 07 Apr 2020 01:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S/OgKdYWLjt9nxR7b6hiqLG5I/KdudWeyxg5+sHq+Ls=;
        b=lCiTWPR1iH6XOM8I+ad6qt8qBTcW7ohlo7enyM1iAH7lQio4xsS8R74+kaLmVQERUJ
         rSm3JhhyYcgTsa4K3LuPr0O68SEvOCWc+nhMEWIqZg8rr+VePCf3/u98IjioqyV05kSX
         q+yn5o6Ps5Cq7UfyGgqkNxFbMyTwqQDoWNhbzUbj7wSWr63xbUQSkMeoxaFrqbr3BUrI
         BlFjPAGHcd8Y6Fd0S8kobj5Iva9YLlh5EnIjC9hzIrer3J+g595a7prwHCSidcys3fJY
         btSuod69KVmODtlqqMFnDOs7C7OyBU4oZOirLPBEkud2gQG8NcmGL6ghK65JVr+00gkv
         0aYw==
X-Gm-Message-State: AGi0PuYmgCrsyCSjE3o+7VYK2esHKH95bos6Ft//zLtFZGC+dLJgUM2m
        uGzAIT4w5rrDKs5s8kfCWbg=
X-Google-Smtp-Source: APiQypLW1ijKZbf6HlxJy+8Mf541KbUjgmxyHaFX5jDhUPioS749bd3R0954qIVQEUBDPZnnCVaN2w==
X-Received: by 2002:a63:5457:: with SMTP id e23mr844543pgm.451.1586246964099;
        Tue, 07 Apr 2020 01:09:24 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 144sm13431470pfx.184.2020.04.07.01.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 01:09:22 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A674A40246; Tue,  7 Apr 2020 08:09:21 +0000 (UTC)
Date:   Tue, 7 Apr 2020 08:09:21 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, mhocko@suse.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [RFC 2/3] blktrace: fix debugfs use after free
Message-ID: <20200407080921.GF11244@42.do-not-panic.com>
References: <20200402000002.7442-1-mcgrof@kernel.org>
 <20200402000002.7442-3-mcgrof@kernel.org>
 <3640b16b-abda-5160-301a-6a0ee67365b4@acm.org>
 <b827d03c-e097-06c3-02ab-00df42b5fc0e@sandeen.net>
 <75aa4cff-1b90-ebd4-17a4-c1cb6d390b30@acm.org>
 <4a84844d-ef87-c609-9963-4dea17bc506c@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a84844d-ef87-c609-9963-4dea17bc506c@sandeen.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 06, 2020 at 09:29:40AM -0500, Eric Sandeen wrote:
> On 4/5/20 11:25 PM, Bart Van Assche wrote:
> > On 2020-04-05 18:27, Eric Sandeen wrote:
> >> The thing I can't figure out from reading the change log is
> >>
> >> 1) what the root cause of the problem is, and
> >> 2) how this patch fixes it?
> > 
> > I think that the root cause is that do_blk_trace_setup() uses
> > debugfs_lookup() and that debugfs_lookup() may return a pointer
> > associated with a previous incarnation of the block device.
> > Additionally, I think the following changes fix that problem by using
> > q->debugfs_dir in the blktrace code instead of debugfs_lookup():
> 
> Yep, I gathered that from reading the patch, was just hoping for a commit log
> that makes it clear.

Will try to be a bit more clear.

> > [ ... ]
> > --- a/kernel/trace/blktrace.c
> > +++ b/kernel/trace/blktrace.c
> > @@ -311,7 +311,6 @@ static void blk_trace_free(struct blk_trace *bt)
> >  	debugfs_remove(bt->msg_file);
> >  	debugfs_remove(bt->dropped_file);
> >  	relay_close(bt->rchan);
> > -	debugfs_remove(bt->dir);
> >  	free_percpu(bt->sequence);
> >  	free_percpu(bt->msg_data);
> >  	kfree(bt);
> > [ ... ]
> > @@ -509,21 +510,19 @@ static int do_blk_trace_setup(struct request_queue
> > *q, char *name, dev_t dev,
> > 
> >  	ret = -ENOENT;
> > 
> > -	dir = debugfs_lookup(buts->name, blk_debugfs_root);
> > -	if (!dir)
> > -		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> > -
> >  	bt->dev = dev;
> >  	atomic_set(&bt->dropped, 0);
> >  	INIT_LIST_HEAD(&bt->running_list);
> > 
> >  	ret = -EIO;
> > -	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
> > +	bt->dropped_file = debugfs_create_file("dropped", 0444,
> > +					       q->debugfs_dir, bt,
> >  					       &blk_dropped_fops);
> 
> One thing I'm not sure about, the block_trace *bt still points to a dentry that
> could get torn down via debugfs_remove_recursive when the queue is released, right,

Yes, but let us be specific, what points to a dentry is the directory,
and then the files liked "dropped" above. In fact, as it turns out, the
relay can also be torn down for us through a debugfs_remove_recursive().

> but could later be sent to blk_trace_free again? 

This *should* not be possible, because the dentries for the blktrace
should not be removed prior to the request_queue being removed, because
the blktrace dentries are protected via a request_queue mutex,
q->blk_trace_mutex.

The blk_trace_free() free should therefore happen way early, before
the request_queue is removed. The only dentry left is the directory
on the q->debugfs_dir, and this should only be removed only later when
the request_queue is removed.

But, this does not happen today. For completeness below is a trace
of a real crash but with some extra information added, such as the
get_cpu() a call runs on, and any other interesting thing which we
might care for at the point a call is made.

Also remember debugfs_remove_recursive() is just a define to debugfs_remove().

I used:

	./break-blktrace -c 10 -d -s

So the teardown of the blktrace is skipped purposely.

The gist of it, is that upon the second loop, the LOOP_CTL_DEL for
loop0 schedules the __blk_release_queue() work, but it at least
gets to call blk_trace_free(), but in the meantime LOOP_CTL_ADD()
from the second loop gets called, without the prior work from the
LOOP_CTL_DEL having completed yet. By the time BLKTRACE_SETUP gets
called, the debugfs_lookup() is used, the directory is used (not
created). Then the old LOOP_CTL_DEL from the same second loop still
has to complete, and so it tries, and as you will see from the trace
below it calls debugfs_remove_recursive(q->debugfs_dir) prior to
the second loops' BLKTRACE_SETUP finishing. The dentries for the
files created for blktrace would be removed. Upon the third loop's
LOOP_CTL_DEL we end up trying to free these dentries again.

load loopback module                                                            
[   13.603371] == blk_mq_debugfs_register(12) start                             
[   13.604040] == blk_mq_debugfs_register(12) q->debugfs_dir created            
[   13.604934] == blk_mq_debugfs_register(12) end                               
[   13.627382] == blk_mq_debugfs_register(12) start                             
[   13.628041] == blk_mq_debugfs_register(12) q->debugfs_dir created            
[   13.629240] == blk_mq_debugfs_register(12) end                               
[   13.651667] == blk_mq_debugfs_register(12) start                             
[   13.652836] == blk_mq_debugfs_register(12) q->debugfs_dir created            
[   13.655107] == blk_mq_debugfs_register(12) end                               
[   13.684917] == blk_mq_debugfs_register(12) start                             
[   13.687876] == blk_mq_debugfs_register(12) q->debugfs_dir created            
[   13.691588] == blk_mq_debugfs_register(13) end                               
[   13.707320] == blk_mq_debugfs_register(13) start                             
[   13.707863] == blk_mq_debugfs_register(13) q->debugfs_dir created            
[   13.708856] == blk_mq_debugfs_register(13) end                               
[   13.735623] == blk_mq_debugfs_register(13) start                             
[   13.736656] == blk_mq_debugfs_register(13) q->debugfs_dir created            
[   13.738411] == blk_mq_debugfs_register(13) end                               
[   13.763326] == blk_mq_debugfs_register(13) start                             
[   13.763972] == blk_mq_debugfs_register(13) q->debugfs_dir created            
[   13.765167] == blk_mq_debugfs_register(13) end                               
[   13.779510] == blk_mq_debugfs_register(13) start                             
[   13.780522] == blk_mq_debugfs_register(13) q->debugfs_dir created            
[   13.782338] == blk_mq_debugfs_register(13) end                               
[   13.783521] loop: module loaded         

LOOP_CTL_DEL(loop0) #1                                                          
[   13.803550] = __blk_release_queue(4) start                                   
[   13.807772] == blk_trace_shutdown(4) start                                   
[   13.810749] == blk_trace_shutdown(4) end                                     
[   13.813437] = __blk_release_queue(4) calling blk_mq_debugfs_unregister()     
[   13.817593] ==== blk_mq_debugfs_unregister(4) begin                          
[   13.817621] ==== blk_mq_debugfs_unregister(4) debugfs_remove_recursive(q->debugfs_dir)
[   13.821203] ==== blk_mq_debugfs_unregister(4) end q->debugfs_dir is NULL     
[   13.826166] = __blk_release_queue(4) blk_mq_debugfs_unregister() end         
[   13.832992] = __blk_release_queue(4) end

LOOP_CTL_ADD(loop0) #1                                                          
[   13.843742] == blk_mq_debugfs_register(7) start                              
[   13.845569] == blk_mq_debugfs_register(7) q->debugfs_dir created             
[   13.848628] == blk_mq_debugfs_register(7) end

BLKTRACE_SETUP(loop0) #1                                                        
[   13.850924] == blk_trace_ioctl(7, BLKTRACESETUP) start                       
[   13.852852] === do_blk_trace_setup(7) start                                  
[   13.854580] === do_blk_trace_setup(7) creating directory                     
[   13.856620] === do_blk_trace_setup(7) using what debugfs_lookup() gave       
[   13.860635] === do_blk_trace_setup(7) end with ret: 0                        
[   13.862615] == blk_trace_ioctl(7, BLKTRACESETUP) end

LOOP_CTL_DEL(loop0) #2                                                          
[   13.883304] = __blk_release_queue(7) start                                   
[   13.885324] == blk_trace_shutdown(7) start                                   
[   13.887197] == blk_trace_shutdown(7) calling __blk_trace_remove()            
[   13.889807] == __blk_trace_remove(7) start                                   
[   13.891669] === blk_trace_cleanup(7) start                                   
[   13.911656] ====== blk_trace_free(7) start  

LOOP_CTL_ADD(loop0) #2                                                          
[   13.912709] == blk_mq_debugfs_register(2) start

---> From LOOP_CTL_DEL(loop0) #2                                                
[   13.915887] ====== blk_trace_free(7) end 

---> From LOOP_CTL_ADD(loop0) #2                                                
[   13.918359] debugfs: Directory 'loop0' with parent 'block' already present!  
[   13.926433] == blk_mq_debugfs_register(2) q->debugfs_dir created             
[   13.930373] == blk_mq_debugfs_register(2) end

BLKTRACE_SETUP(loop0) #2                                                        
[   13.933961] == blk_trace_ioctl(2, BLKTRACESETUP) start                       
[   13.936758] === do_blk_trace_setup(2) start                                  
[   13.938944] === do_blk_trace_setup(2) creating directory                     
[   13.941029] === do_blk_trace_setup(2) using what debugfs_lookup() gave

---> From LOOP_CTL_DEL(loop0) #2                                                
[   13.971046] === blk_trace_cleanup(7) end                                     
[   13.973175] == __blk_trace_remove(7) end                                     
[   13.975352] == blk_trace_shutdown(7) end                                     
[   13.977415] = __blk_release_queue(7) calling blk_mq_debugfs_unregister()     
[   13.980645] ==== blk_mq_debugfs_unregister(7) begin                          
[   13.980696] ==== blk_mq_debugfs_unregister(7) debugfs_remove_recursive(q->debugfs_dir)
[   13.983118] ==== blk_mq_debugfs_unregister(7) end q->debugfs_dir is NULL     
[   13.986945] = __blk_release_queue(7) blk_mq_debugfs_unregister() end         
[   13.993155] = __blk_release_queue(7) end 

---> From BLKTRACE_SETUP(loop0) #2                                              
[   13.995928] === do_blk_trace_setup(2) end with ret: 0                        
[   13.997623] == blk_trace_ioctl(2, BLKTRACESETUP) end   

LOOP_CTL_DEL(loop0) #3                                                          
[   14.035119] = __blk_release_queue(2) start                                   
[   14.036925] == blk_trace_shutdown(2) start                                   
[   14.038518] == blk_trace_shutdown(2) calling __blk_trace_remove()            
[   14.040829] == __blk_trace_remove(2) start                                   
[   14.042413] === blk_trace_cleanup(2) start 

LOOP_CTL_ADD(loop0) #3                                                          
[   14.072522] == blk_mq_debugfs_register(6) start 

---> From LOOP_CTL_DEL(loop0) #3                                                
[   14.075151] ====== blk_trace_free(2) start 

---> From LOOP_CTL_ADD(loop0) #3                                                
[   14.075882] == blk_mq_debugfs_register(6) q->debugfs_dir created  

---> From LOOP_CTL_DEL(loop0) #3                                                
[   14.078624] BUG: kernel NULL pointer dereference, address: 00000000000000a0  
[   14.084332] == blk_mq_debugfs_register(6) end                                
[   14.086971] #PF: supervisor write access in kernel mode                      
[   14.086974] #PF: error_code(0x0002) - not-present page                       
[   14.086977] PGD 0 P4D 0                                                      
[   14.086984] Oops: 0002 [#1] SMP NOPTI                                        
[   14.086990] CPU: 2 PID: 287 Comm: kworker/2:2 Tainted: G            E 5.6.0-next-20200403+ #54
[   14.086991] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
[   14.087002] Workqueue: events __blk_release_queue                            
[   14.087011] RIP: 0010:down_write+0x15/0x40                                   
[   14.090300] == blk_trace_ioctl(6, BLKTRACESETUP) start                       
[   14.093277] Code: eb ca e8 3e 34 8d ff cc cc cc cc cc cc cc cc cc cc
cc cc cc cc 0f 1f 44 00 00 55 48 89 fd e8 52 db ff ff 31 c0 ba 01 00 00
00 <f0> 48 0f b1 55 00 75 0f 65 48 8b 04 25 c0 8b 01 00 48 89 45 08 5d
[   14.093280] RSP: 0018:ffffc28a00533da8 EFLAGS: 00010246                      
[   14.093284] RAX: 0000000000000000 RBX: ffff9f7a24d07980 RCX: ffffff8100000000
[   14.093286] RDX: 0000000000000001 RSI: ffffff8100000000 RDI: 00000000000000a0
[   14.093287] RBP: 00000000000000a0 R08: 0000000000000000 R09: 0000000000000019
[   14.093289] R10: 0000000000000774 R11: 0000000000000000 R12: 0000000000000000
[   14.093291] R13: ffff9f7a2fab0400 R14: ffff9f7a21dd1140 R15: 00000000000000a0
[   14.093294] FS:  0000000000000000(0000) GS:ffff9f7a2fa80000(0000) knlGS:0000000000000000
[   14.093296] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033                
[   14.093298] CR2: 00000000000000a0 CR3: 00000004293d2003 CR4: 0000000000360ee0
[   14.093307] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   14.093308] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   14.093310] Call Trace:                                                      
[   14.093324]  simple_recursive_removal+0x4e/0x2e0                             
[   14.093330]  ? debugfs_remove+0x60/0x60                                      
[   14.093334]  debugfs_remove+0x40/0x60                                        
[   14.093339]  blk_trace_free+0x20/0x70                                        
[   14.093346]  __blk_trace_remove+0x54/0x90                                    
[   14.096704] === do_blk_trace_setup(6) start                                  
[   14.098534]  blk_trace_shutdown+0x74/0x80                                    
[   14.100958] === do_blk_trace_setup(6) creating directory                     
[   14.104575]  __blk_release_queue+0xbe/0x160                                  
[   14.104580]  process_one_work+0x1b4/0x380                                    
[   14.104585]  worker_thread+0x50/0x3c0                                        
[   14.104589]  kthread+0xf9/0x130            
[   14.104593]  ? process_one_work+0x380/0x380                                  
[   14.104596]  ? kthread_park+0x90/0x90                                        
[   14.104599]  ret_from_fork+0x1f/0x40                                         
[   14.104603] Modules linked in: loop(E) xfs(E) libcrc32c(E)
crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) joydev(E)
serio_raw(E) aesni_intel(E) glue_helper(E) virtio_balloon(E) evdev(E)
crypto_simd(E) pcspkr(E) cryptd(E) i6300esb(E) button(E) ip_tables(E)
x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(E)
jbd2(E) virtio_net(E) net_failover(E) failover(E) virtio_blk(E)
ata_generic(E) uhci_hcd(E) ata_piix(E) ehci_hcd(E) nvme(E) libata(E)
crc32c_intel(E) usbcore(E) psmouse(E) nvme_core(E) virtio_pci(E)
scsi_mod(E) virtio_ring(E) t10_pi(E) virtio(E) i2c_piix4(E) floppy(E)
[   14.107400] === do_blk_trace_setup(6) using what debugfs_lookup()
gave       
[   14.108939] CR2: 00000000000000a0                                            
[   14.110589] === do_blk_trace_setup(6) end with ret: 0                        
[   14.111592] ---[ end trace 7a783b33b9614db9 ]---

> And yet this does seem to fix the
> use after free in my testing, so I must be missing something.

The fragility is in the use of the debugfs_lookup(), and since that
doesn't protect the files we create underneath it. We also dput()
right away, and even if we didn't, if you try to fix that you'll
soon see that this is just a hot mess with the debugfs directories
used.

It is much cleaner to have one directory which we don't have to
worry about for its life, the complexities around special casing
it for mq or not is what gets this thing to be sloppy.

One thing we could do to avoid conflicts with removal and a setup
is:

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 15086227592f..e3d4809a2964 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -701,6 +701,9 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	if (!q)
 		return -ENXIO;
 
+	if (work_pending(&q->release_work))
+		return -ENXIO;
+
 	mutex_lock(&q->blk_trace_mutex);
 
 	switch (cmd) {

