Return-Path: <linux-fsdevel+bounces-43113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9CAA4E295
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 16:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596B13BAEBD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 14:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F2923957E;
	Tue,  4 Mar 2025 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="r44fN8oo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E7E26657B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100180; cv=none; b=OY+cvnAkpi4Pp/GX3QJWI0X7Sxm3xu1z4zlxdvd58RMvCb3ZAwdv9mXPt5s+8DBcQMkRJiPVX8DyOwpPRqxCUwVlv4Ej19zCJ/BFHCyDVdpfzhVUBkrb/Eca8H15naFmkwTrYWrZFELvJt3BcY83oZc542L42ir16GIQBTF/M4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100180; c=relaxed/simple;
	bh=olPy4TFGven851f7JIzuda2J795yql395yGWoBUVj9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fp0qWNcOApGwMJZtW/gcFoJoNv1O0pot2BStY/s03MVpTbrHn2RHVf7pNVwTQzDADZ8N9H+oKhTtmWFHsDXSNKmo/pZEBDiqE+9yjX0HmsG6gCuO0d75VibpdqkV2rxfAWSc+J/ZpJOwSYKrAVVMRSqKGcdG0pIov6Wn+0ylPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=r44fN8oo; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e89959f631so44689576d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 06:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1741100177; x=1741704977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BKjhbMRpVxhLWoVmqLkt5oUi5zCGDbWxG+lFjOhMw8E=;
        b=r44fN8oo9SNEtOBZISIUGnnDf/Wz0nbyZugNmrcjHTmlFMNE7kuJN+2pic9qXHYq3c
         7lCaCnTcqB0PWGQN2Ubi3rmEmu0PadVIC/yWF8r+FSM8tgoIG/USOqcBBpK1NFLxbxJe
         Ag5XIvWwqRIQ3fSyXvgIVIBuLZsYTm+H5LJdkjoJxPo7CwD4OwMKHtu9LMeLefybCORp
         YS4OmWIPhLz1cwnvdYdqz9aNGxB5JOm1pV9jhtBcXWbpzI4AaP84Nv749fk9Ym1s46+4
         ZHwLIYd1YUp2tud4SaHvfHznpKhpEhRt/E4YaE+ihE44VEjuNQO7WdLPQV6IyU73czy4
         JOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100177; x=1741704977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKjhbMRpVxhLWoVmqLkt5oUi5zCGDbWxG+lFjOhMw8E=;
        b=aQbA/mYlVDqakptt8hCT+5kP8aycMUQrp+1dlY+qM2eT1digP77eRuMGSle167Spx+
         vIcR3cAzFCeGynvA4As0uk1Q2QV01SnN5EmVj6Guq1aeNjkVA2JiCwyLIAtEwjEXyCwR
         sTbErlU7MscMp8OExzZLB4hNHL/EIszAEus/DEjRn4j1jfnnqRfflrhBfiz9emglaqWR
         M04rn9zBLr80GWJ9KHu1H7WPksfeJtzNittKoNYP5EPDVn0ZjfRLLHC30fOoL3KINqRM
         Ug/VVlgkJF3kRKNjHqVto6fn+TTSS93kIEHllg/2tVR39JMPsJeYqipVOw5U6vsc3afk
         sY/g==
X-Gm-Message-State: AOJu0YxUmVGemWnU1Fx84lZlv20BFW01MhVp8YbDa4LAxBrabkBn3yP/
	yllkX8ubKoQ2+3+R7Fzjc4kLrDDHMG5GnNyJ1T3s8AX1TccIo+1wUVrvkcKGr+c=
X-Gm-Gg: ASbGncvv+kgSDJAKNKhG1NUN+WZ2A9NhkThXtjpcd0ttsdaPFtMNTduKb5D5swKHn8t
	8pmFDoKZ0QOub1MUvfrKMpH8RSkmrfzxb/P7ELjBwtMwVHMFqvl7o2D+TbuTR1mI1IqtKc+rXag
	gLxc1Vg3Qu+LMdHLkUvVgkqY5Fb6rUO+7xg+5wk5jh2oJd5V+HH2aRJyboI6MLhpX6SUv9VVZFU
	1vV2Zc8HmjTv20O3bY3dTdPibmAKfkaAMeuiCOfiyFJ2HVi1TIAieve0swHdGIOHRTUGgXmmgWE
	mRmXiIP87hRszE2cgPOwmsWXqwPgnCSdQu4EO6AAJuW1VHqi5CXdaYi/xyGmlJ9c39NM9oqf7WM
	g8QYplg==
X-Google-Smtp-Source: AGHT+IEj2NqEXqk7+r+28I6vp2NfPMRWGpvxopnpfya0kRmweaNncxvtvwj+CpdL3RYzMk9xUFTHOw==
X-Received: by 2002:a05:6214:2586:b0:6e8:9fdf:5923 with SMTP id 6a1803df08f44-6e8a0c7d07amr256811046d6.5.1741100176627;
        Tue, 04 Mar 2025 06:56:16 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e89766087dsm67480656d6.52.2025.03.04.06.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:56:16 -0800 (PST)
Date: Tue, 4 Mar 2025 09:56:14 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Changing reference counting rules for inodes
Message-ID: <20250304145614.GA4043425@perftesting>
References: <20250303170029.GA3964340@perftesting>
 <20250304-flexibel-glimmen-ccb3a5a71cc6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-flexibel-glimmen-ccb3a5a71cc6@brauner>

On Tue, Mar 04, 2025 at 11:19:34AM +0100, Christian Brauner wrote:
> On Mon, Mar 03, 2025 at 12:00:29PM -0500, Josef Bacik wrote:
> > Hello,
> > 
> > I've recently gotten annoyed with the current reference counting rules that
> > exist in the file system arena, specifically this pattern of having 0 referenced
> > objects that indicate that they're ready to be reclaimed.
> > 
> > This pattern consistently bites us in the ass, is error prone, gives us a lot of
> > complicated logic around when an object is actually allowed to be touched versus
> > when it is not.
> > 
> > We do this everywhere, with inodes, dentries, and folios, but I specifically
> > went to change inodes recently thinking it would be the easiest, and I've run
> > into a few big questions.  Currently I've got about ~30 patches, and that is
> > mostly just modifying the existing file systems for a new inode_operation.
> > Before I devote more time to this silly path, I figured it'd be good to bring it
> > up to the group to get some input on what possible better solutions there would
> > be.
> > 
> > I'll try to make this as easy to follow as possible, but I spent a full day and
> > a half writing code and thinking about this and it's kind of complicated.  I'll
> > break this up into sections to try and make it easier to digest.
> > 
> > WHAT DO I WANT
> > 
> > I want to have refcount 0 == we're freeing the object.  This will give us clear
> > "I'm using this object, thus I have a reference count on it" rules, and we can
> > (hopefully) eliminate a lot of the complicated freeing logic (I_FREEING |
> > I_WILL_FREE).
> 
> Yeah, I want to see I_FREEING and I_WILL_FREE stuff to go away. This bit
> fiddling and waiting is terribly opaque for anyone who hasn't worked on
> this since the dawn of time. So I'm all for it.
> 
> > 
> > HOW DO I WANT TO DO THIS
> > 
> > Well obviously we keep a reference count always whenever we are using the inode,
> > and we hold a reference when it is on a list.  This means the i_io_list holds a
> > reference to the inode, that means the LRU list holds a reference to the inode.
> > 
> > This makes LRU handling easier, we just walk the objects and drop our reference
> > to the object.  If it was truly the last reference then we free it, otherwise it
> > will get added back onto the LRU list when the next guy does an iput().
> > 
> > POTENTIAL PROBLEM #1
> > 
> > Now we're actively checking to see if this inode is on the LRU list and
> > potentially taking the lru list lock more often.  I don't think this will be the
> > case, as we would check the inode flags before we take the lock, so we would
> > martinally increase the lock contention on the LRU lock.  We could mitigate this
> > by doing the LRU list add at lookup time, where we already have to grab some of
> > these locks, but I don't want to get into premature optimization territory here.
> > I'm just surfacing it as a potential problem.
> 
> Yes, ignore it for now.
> 
> So I agree that if we can try and remove the inode cache altogether that
> would be pretty awesome and we know that we have support for attempting
> that from Linus. But I'm not sure what regression potential that has.
> There might just be enough implicit behavior that workloads depend on
> that will bite us in the ass.
> 
> But I don't think you need to address this in this series. Your changes
> might end up making it easier to experiemnt with the inode cache removal
> though.
> 
> > POTENTIAL PROBLEM #2
> > 
> > We have a fair bit of logic in writeback around when we can just skip writeback,
> > which amounts to we're currently doing the final truncate on an inode with
> > ->i_nlink set.  This is kind of a big problem actually, as we could no
> > potentially end up with a large dirty inode that has an nlink of 0, and no
> > current users, but would now be written back because it has a reference on it
> > from writeback.  Before we could get into the iput() and clean everything up
> > before writeback would occur.  Now writeback would occur, and then we'd clean up
> > the inode.
> 
> So in the old pattern you'd call iput_final() and then do writeback.
> Whereas in the new pattern you'd do writeback before iput_final().
> And this is a problem because it potentially delays freeing of the inode
> for a long time?

Well we don't do the writeback in iput_final() if we've unlinked the inode.

Currently, you can have the following sequence of events

Open file
Write to file
Unlink file
Close file
  iput_final()
    remove the inode from the io_list
    wait on current writeback that may have started before the iput_final()
    truncate the inode
    truncate the page cache

In this case we avoid the writeout completely, because once we've entered
iput_final() and set I_FREEING the writeback threads will skip that inode if
they try to write it back, so we skip a whole writeback cycle.

With my naive implementation of just holding reference counts for everything,
writeback now holds its reference, so what would happen now is

Open file
Write to file
Unlink file
Close file
<some time passes>
Writeback occurs on the file
  iput_final()
    truncate the inode

So now we've written back the inode, and then we truncate it. Is this bad? Not
really, unless you're workload does this and you're on SSD's, now you've got
more write cycles than you had before.  The slightly bigger problem is now
you've got the final iput happening in the writeback threads, which will induce
latency in the whole system.

> 
> > 
> > SOLUTION FOR POTENTIAL PROBLEM #1
> > 
> > I think we ignore this for now, get the patches written, do some benchmarking
> > and see if this actually shows up in benchmarks.  If it does then we come up
> > with strategies to resolve this at that point.
> > 
> > SOLUTION FOR POTENTIAL PROBLEM #2 <--- I would like input here
> > 
> > My initial thought was to just move the final unlink logic outside of evict, and
> > create a new reference count that represents the actual use of the inode.  Then
> > when the actual use went to 0 we would do the final unlink, de-coupling the
> > cleanup of the on-disk inode (in the case of local file systems) from the
> > freeing of the memory.
> 
> I really do like active/passive reference counts. I've used that pattern
> for mount namespaces, seccomp filters and some other stuff quite
> successfully. So I'm somewhat inclined to prefer that solution.
> 
> Imho, when active/reference patterns are needed or useful then it's
> almost always because the original single reference counting mechanism
> was semantically vague because it mixed two different meanings of the
> reference count. So switching to an active/passive pattern will end up
> clarifying things.
> 

Ok cool, that's the path I wandered down and then wanted to make sure everybody
else was cool with it.  I'll finish up these patches and get some testing in and
get them out so we can have something concrete to look at.  I'm limiting my
kernel development time to Fridays so it'll be either end of the week or next
week when the patches show up.  Thanks,

Josef

