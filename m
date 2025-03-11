Return-Path: <linux-fsdevel+bounces-43726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BACF0A5CD62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 19:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51093189EA23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 18:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65743262D3A;
	Tue, 11 Mar 2025 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlImda2i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C269C25C6FF
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716700; cv=none; b=aI2JWBKEbX7IUdNxq6wDgKjyFD3Huby3c1uyii65r5SpdNFzMUFUOb5LKdRulzJtrAzRJE+p0gCkVjLMv8sssLXOj1ZR+Rk41i7xWbtA6T8WIr1yuGBeFaVawlRv9Nt0FdQyiEBh/vcSf5BztbKEc+QMnFySzm9M+ATWY806IUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716700; c=relaxed/simple;
	bh=KBLzAKP7Jy1XkHPBNjtbBtgqPwrEX3OUsGIe+loVd1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCqT6ZWSJAE1jxDoCJ+ylU8K3NHDvuhzkLxIIHtSPYZpMElbEs+JsQnaezzfRWxSkIArtwFLbTad3BdZ+SS/+8MdAg3T+sXOXSVJSKXPazMalZ0KMX92CW4Rb7ftBbyRgnZgiOplQ1e8X9SU1SOh1IbdILF5ltUf+bEy2bnem4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlImda2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB53C4CEEA;
	Tue, 11 Mar 2025 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741716700;
	bh=KBLzAKP7Jy1XkHPBNjtbBtgqPwrEX3OUsGIe+loVd1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZlImda2iId2wZKFB/7ySIYinZtlMyl8vyd2DnILm76mIWNMJjc7EhuaucwqmWNRky
	 7PCR/jn2OCWVB3T+wjink/WEH+pr2CvdikvIgTlO06C1fqwkZGFY6nOv6LsSgVye3p
	 njJuzZm+JPahoCJm3n4VEjv53ZuEO5ah4cGrPR1HBFfFaEOT7Up7GtK06q/0irTLlU
	 LWzViEW7NztjdTPNINJIlFp8y9wkQR5ZpGO0d0Jv9vwIF22n88BMpO+BWtlTtObBHZ
	 sEg/imeUzLTeVYgrfACtX3WTpafLlKMRuJ+5gPE1nuFiViNztsysxqfIk+CYtwBcUw
	 Y+d2W+88lVlSQ==
Date: Tue, 11 Mar 2025 11:11:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Sun Yongjian <sunyongjian1@huawei.com>, linux-fsdevel@vger.kernel.org,
	yangerkun@huawei.com
Subject: Re: [PATCH] Revert "libfs: Use d_children list to iterate
 simple_offset directories"
Message-ID: <20250311181139.GC2803730@frogsfrogsfrogs>
References: <2025022644-blinked-broadness-c810@gregkh>
 <a7fe0eda-78e4-43bb-822b-c1dfa65ba4dd@oracle.com>
 <2025022621-worshiper-turtle-6eb1@gregkh>
 <a2e5de22-f5d1-4f99-ab37-93343b5c68b1@oracle.com>
 <2025022612-stratus-theology-de3c@gregkh>
 <ca00f758-2028-49da-a2fe-c8c4c2b2cefd@oracle.com>
 <2025031039-gander-stamina-4bb6@gregkh>
 <d61acb5f-118e-4589-978c-1107d307d9b5@oracle.com>
 <691e95db-112e-4276-9de4-03a383ff4bfe@huawei.com>
 <f73e4e72-c46d-499b-a5d6-bf469331d496@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f73e4e72-c46d-499b-a5d6-bf469331d496@oracle.com>

On Tue, Mar 11, 2025 at 11:23:04AM -0400, Chuck Lever wrote:
> On 3/11/25 9:55 AM, Sun Yongjian wrote:
> > 
> > 
> > 在 2025/3/11 1:30, Chuck Lever 写道:
> >> On 3/10/25 12:29 PM, Greg Kroah-Hartman wrote:
> >>> On Wed, Feb 26, 2025 at 03:33:56PM -0500, Chuck Lever wrote:
> >>>> On 2/26/25 2:13 PM, Greg Kroah-Hartman wrote:
> >>>>> On Wed, Feb 26, 2025 at 11:28:35AM -0500, Chuck Lever wrote:
> >>>>>> On 2/26/25 11:21 AM, Greg Kroah-Hartman wrote:
> >>>>>>> On Wed, Feb 26, 2025 at 10:57:48AM -0500, Chuck Lever wrote:
> >>>>>>>> On 2/26/25 9:29 AM, Greg Kroah-Hartman wrote:
> >>>>>>>>> This reverts commit b9b588f22a0c049a14885399e27625635ae6ef91.
> >>>>>>>>>
> >>>>>>>>> There are reports of this commit breaking Chrome's rendering
> >>>>>>>>> mode.  As
> >>>>>>>>> no one seems to want to do a root-cause, let's just revert it
> >>>>>>>>> for now as
> >>>>>>>>> it is affecting people using the latest release as well as the
> >>>>>>>>> stable
> >>>>>>>>> kernels that it has been backported to.
> >>>>>>>>
> >>>>>>>> NACK. This re-introduces a CVE.
> >>>>>>>
> >>>>>>> As I said elsewhere, when a commit that is assigned a CVE is
> >>>>>>> reverted,
> >>>>>>> then the CVE gets revoked.  But I don't see this commit being
> >>>>>>> assigned
> >>>>>>> to a CVE, so what CVE specifically are you referring to?
> >>>>>>
> >>>>>> https://nvd.nist.gov/vuln/detail/CVE-2024-46701
> >>>>>
> >>>>> That refers to commit 64a7ce76fb90 ("libfs: fix infinite directory
> >>>>> reads
> >>>>> for offset dir"), which showed up in 6.11 (and only backported to
> >>>>> 6.10.7
> >>>>> (which is long end-of-life).  Commit b9b588f22a0c ("libfs: Use
> >>>>> d_children list to iterate simple_offset directories") is in 6.14-rc1
> >>>>> and has been backported to 6.6.75, 6.12.12, and 6.13.1.
> >>>>>
> >>>>> I don't understand the interaction here, sorry.
> >>>>
> >>>> Commit 64a7ce76fb90 is an attempt to fix the infinite loop, but can
> >>>> not be applied to kernels before 0e4a862174f2 ("libfs: Convert simple
> >>>> directory offsets to use a Maple Tree"), even though those kernels also
> >>>> suffer from the looping symptoms described in the CVE.
> >>>>
> >>>> There was significant controversy (which you responded to) when Yu Kuai
> >>>> <yukuai3@huawei.com> attempted a backport of 64a7ce76fb90 to address
> >>>> this CVE in v6.6 by first applying all upstream mtree patches to v6.6.
> >>>> That backport was roundly rejected by Liam and Lorenzo.
> >>>>
> >>>> Commit b9b588f22a0c is a second attempt to fix the infinite loop
> >>>> problem
> >>>> that does not depend on having a working Maple tree implementation.
> >>>> b9b588f22a0c is a fix that can work properly with the older xarray
> >>>> mechanism that 0e4a862174f2 replaced, so it can be backported (with
> >>>> certain adjustments) to kernels before 0e4a862174f2.
> >>>>
> >>>> Note that as part of the series where b9b588f22a0c was applied,
> >>>> 64a7ce76fb90 is reverted (v6.10 and forward). Reverting b9b588f22a0c
> >>>> leaves LTS kernels from v6.6 forward with the infinite loop problem
> >>>> unfixed entirely because 64a7ce76fb90 has also now been reverted.
> >>>>
> >>>>
> >>>>>> The guideline that "regressions are more important than CVEs" is
> >>>>>> interesting. I hadn't heard that before.
> >>>>>
> >>>>> CVEs should not be relevant for development given that we create 10-11
> >>>>> of them a day.  Treat them like any other public bug list please.
> >>>>>
> >>>>> But again, I don't understand how reverting this commit relates to the
> >>>>> CVE id you pointed at, what am I missing?
> >>>>>
> >>>>>> Still, it seems like we haven't had a chance to actually work on this
> >>>>>> issue yet. It could be corrected by a simple fix. Reverting seems
> >>>>>> premature to me.
> >>>>>
> >>>>> I'll let that be up to the vfs maintainers, but I'd push for reverting
> >>>>> first to fix the regression and then taking the time to find the real
> >>>>> change going forward to make our user's lives easier.  Especially as I
> >>>>> don't know who is working on that "simple fix" :)
> >>>>
> >>>> The issue is that we need the Chrome team to tell us what new system
> >>>> behavior is causing Chrome to malfunction. None of us have expertise to
> >>>> examine as complex an application as Chrome to nail the one small
> >>>> change
> >>>> that is causing the problem. This could even be a latent bug in Chrome.
> >>>>
> >>>> As soon as they have reviewed the bug and provided a simple reproducer,
> >>>> I will start active triage.
> >>>
> >>> What ever happened with all of this?
> >>
> >> https://issuetracker.google.com/issues/396434686?pli=1
> >>
> >> The Chrome engineer chased this into the Mesa library, but since then
> >> progress has slowed. We still don't know why GPU acceleration is not
> >> being detected on certain devices.
> >>
> >>
> > Hello,
> > 
> > 
> > I recently conducted an experiment after applying the patch "libfs: Use
> > d_children
> > 
> > list to iterate simple_offset directories."  In a directory under tmpfs,
> > I created 1026
> > 
> > files using the following commands:
> > for i in {1..1026}; do
> >     echo "This is file $i" > /tmp/dir/file$i
> > done
> > 
> > When I use the ls to read the contents of the dir, I find that glibc
> > performs two
> > 
> > rounds of readdir calls due to the large number of files. The first
> > readdir populates
> > 
> > dirent with file1026 through file5, and the second readdir populates it
> > with file4
> > 
> > through file1, which are then returned to user space.
> > 
> > If an unlink file4 operation is inserted between these two readdir
> > calls, the second
> > 
> > readdir will return file5, file3, file2, and file1, causing ls to
> > display two instances of
> > 
> > file5. However, if we replace mas_find with mas_find_rev in the
> > offset_dir_lookup
> > 
> > function, the results become normal.
> > 
> > I'm not sure whether this experiment could shed light on a potential
> > fix.
> 
> Thanks for the report. Directory contents cached in glibc make this
> stack more brittle than it needs to be, certainly. Your issue does
> look like a bug that is related to the commit.
> 
> We believe the GPU acceleration bug is related to directory order,
> but I don't think libdrm is removing an entry from /dev/dri, so I
> am a little skeptical this is the cause of the GPU acceleration issue
> (could be wrong though).
> 
> What I recommend you do is:
> 
>  a. Create a full patch (with S-o-b) that replaces mas_find() with
>     mas_find_rev() in offset_dir_lookup()
> 
>  b. Construct a new fstests test that looks for this problem (and
>     it would be good to investigate fstests to see if it already
>     looks for this issue, but I bet it does not)
> 
>  c. Run the full fstests suite against a kernel before and after you
>     apply a. and confirm that the problem goes away and does not
>     introduce new test failures when a. is applied
> 
>  d. If all goes to plan, post a. to linux-fsdevel and linux-mm.

Just to muddy the waters even more... I decided to look at /dev/block
(my VMs don't have GPUs).  An old 6.13 kernel behaves like this:

$ strace -s99 -o /tmp/log -egetdents64 -vvvvvvv ls /dev/block/  ; cat /tmp/log | sed -e 's/}, /},\n/g' | grep -E '(d_off|d_name)'
7:0  7:1  7:2  7:3  7:4  7:5  7:6  7:7  8:0  8:16  8:32  8:48  8:64  8:80
getdents64(3, [{d_ino=162, d_off=1, d_reclen=24, d_type=DT_DIR, d_name="."},
{d_ino=1, d_off=3, d_reclen=24, d_type=DT_DIR, d_name=".."},
{d_ino=394, d_off=5, d_reclen=24, d_type=DT_LNK, d_name="7:0"},
{d_ino=398, d_off=7, d_reclen=24, d_type=DT_LNK, d_name="7:2"},
{d_ino=388, d_off=9, d_reclen=24, d_type=DT_LNK, d_name="7:1"},
{d_ino=391, d_off=11, d_reclen=24, d_type=DT_LNK, d_name="7:3"},
{d_ino=400, d_off=13, d_reclen=24, d_type=DT_LNK, d_name="7:4"},
{d_ino=402, d_off=15, d_reclen=24, d_type=DT_LNK, d_name="7:6"},
{d_ino=396, d_off=17, d_reclen=24, d_type=DT_LNK, d_name="7:7"},
{d_ino=392, d_off=19, d_reclen=24, d_type=DT_LNK, d_name="7:5"},
{d_ino=419, d_off=21, d_reclen=24, d_type=DT_LNK, d_name="8:0"},
{d_ino=415, d_off=23, d_reclen=24, d_type=DT_LNK, d_name="8:48"},
{d_ino=407, d_off=25, d_reclen=24, d_type=DT_LNK, d_name="8:64"},
{d_ino=411, d_off=27, d_reclen=24, d_type=DT_LNK, d_name="8:80"},
{d_ino=424, d_off=29, d_reclen=24, d_type=DT_LNK, d_name="8:32"},
{d_ino=458, d_off=30, d_reclen=24, d_type=DT_LNK, d_name="8:16"}], 32768) = 384

The loop driver loads before scsi, so it looks like the directory
offsets are recorded in the order that block devices are created.
Next, I create a file, and do this again:

$ sudo touch /dev/block/fubar
$ strace -s99 ...
<snip>
{d_ino=411, d_off=27, d_reclen=24, d_type=DT_LNK, d_name="8:80"},
{d_ino=424, d_off=29, d_reclen=24, d_type=DT_LNK, d_name="8:32"},
{d_ino=458, d_off=44, d_reclen=24, d_type=DT_LNK, d_name="8:16"},
{d_ino=945, d_off=45, d_reclen=32, d_type=DT_REG, d_name="fubar"}], 32768) = 416

Note that the offset of "8:16" has changed from 30 to 44 even though we
didn't touch it.  The new "fubar" entry gets offset 45.  That's not
good, directory offsets are supposed to be stable as long as the entry
isn't modified.  If someone called getdents with offset 31 at the same
time, we'll return "8:16" a second time even though (AFAICT) nothing
changed.

Now I delete "fubar":

$ sudo rm -f /dev/block/fubar
$ strace -s99 ...
<snip>
{d_ino=411, d_off=27, d_reclen=24, d_type=DT_LNK, d_name="8:80"},
{d_ino=424, d_off=29, d_reclen=24, d_type=DT_LNK, d_name="8:32"},
{d_ino=458, d_off=30, d_reclen=24, d_type=DT_LNK, d_name="8:16"}], 32768) = 384

...and curiously "8:16" has gone back to offset 30 even though I didn't
touch that directory entry.

Now let's go look at 6.14-rc6:

$ strace -s99 -o /tmp/log -egetdents64 -vvvvvvv ls /dev/block/  ; cat /tmp/log | sed -e 's/}, /},\n/g' | grep -E '(d_off|d_name)'
7:0  7:1  7:2  7:3  7:4  7:5  7:6  7:7  8:0  8:16  8:32  8:48  8:64  8:80
getdents64(3, [{d_ino=164, d_off=1, d_reclen=24, d_type=DT_DIR, d_name="."},
{d_ino=1, d_off=28, d_reclen=24, d_type=DT_DIR, d_name=".."},
{d_ino=452, d_off=26, d_reclen=24, d_type=DT_LNK, d_name="8:16"},
{d_ino=424, d_off=22, d_reclen=24, d_type=DT_LNK, d_name="8:48"},
{d_ino=420, d_off=24, d_reclen=24, d_type=DT_LNK, d_name="8:80"},
{d_ino=416, d_off=30, d_reclen=24, d_type=DT_LNK, d_name="8:0"},
{d_ino=412, d_off=20, d_reclen=24, d_type=DT_LNK, d_name="8:32"},
{d_ino=408, d_off=12, d_reclen=24, d_type=DT_LNK, d_name="8:64"},
{d_ino=402, d_off=8, d_reclen=24, d_type=DT_LNK, d_name="7:6"},
{d_ino=400, d_off=14, d_reclen=24, d_type=DT_LNK, d_name="7:7"},
{d_ino=398, d_off=16, d_reclen=24, d_type=DT_LNK, d_name="7:5"},
{d_ino=396, d_off=7, d_reclen=24, d_type=DT_LNK, d_name="7:4"},
{d_ino=395, d_off=18, d_reclen=24, d_type=DT_LNK, d_name="7:3"},
{d_ino=392, d_off=10, d_reclen=24, d_type=DT_LNK, d_name="7:2"},
{d_ino=390, d_off=6, d_reclen=24, d_type=DT_LNK, d_name="7:1"},
{d_ino=389, d_off=2147483647, d_reclen=24, d_type=DT_LNK, d_name="7:0"}], 32768) = 384

It's a little weird that the names are returned in reverse order of
their creation, or so I gather from the names, module probe order, and
inode numbers.  I /think/ this is a result of using d_first_child to find the
first dirent, and then walking the sibling list, because new dentries
are hlist_add_head'd to parent->d_children.

But look at the offsets -- they wander all over the place.  You would
think that they would be in decreasing order given that we're actually
walking the dentries in reverse creation order.  But instead they wander
around a lot: 2^31 -> 6 -> 10 -> 18 -> 7?

It's also weird that ".." gets offset 28.  Usually the dot entries come
first both as returned records and in d_off order.

However -- the readdir cursor is set to d_off and copied to userspace so
that the next readdir call can read it and restart iteration at that
offset.  If, say, the getdents buffer was only large enough to get as
far as "8:0", then the cursor position will be set to 30, and the next
getdents call will restart at 30.  The other entries "8:32" to "7:1"
will be skipped because their offsets are less than 30.  Curiously, the
6.13 code sets ctx->pos to dentry2offset() + 1, whereas 6.14 doesn't do
the "+ 1".  I think this means "8:0" can be returned twice.

Most C libraries pass in a large(ish) 32K buffer to getdents and the
directories aren't typically that large so few people will notice this
potential for skips.

Now we add a file:

$ sudo touch /dev/block/fubar
$ strace -s99 -o /tmp/log -egetdents64 -vvvvvvv ls /dev/block/  ; cat /tmp/log | sed -e 's/}, /},\n/g' | grep -E '(d_off|d_name)'
7:0  7:1  7:2  7:3  7:4  7:5  7:6  7:7  8:0  8:16  8:32  8:48  8:64  8:80  fubar
getdents64(3, [{d_ino=164, d_off=1, d_reclen=24, d_type=DT_DIR, d_name="."},
{d_ino=1, d_off=47, d_reclen=24, d_type=DT_DIR, d_name=".."},
{d_ino=948, d_off=28, d_reclen=32, d_type=DT_REG, d_name="fubar"},
{d_ino=452, d_off=26, d_reclen=24, d_type=DT_LNK, d_name="8:16"},
{d_ino=424, d_off=22, d_reclen=24, d_type=DT_LNK, d_name="8:48"},
<snip>

The dotdot entry has a different d_off now, which is strange because I
/know/ I didn't move /dev/block around.

So I can see two problems here: entries need to be returned in
increasing d_off order which is key to correct iteration of a directory;
and it might be the case that userspace is overly reliant on devtmpfs
returning filenames order of increasing age.  Between 6.13 and 6.14 the
mtree_alloc_cyclic in simple_offset_add doesn't look too much different
other than range_hi being decreased to S32_MAX, but offset_iterate_dir
clearly used to do by-offset lookups to return names in increasing d_off
order.

There's also still the weird problem of the dotdot offset changing, I
can't tell if there's a defect in the maple tree or if someone actually
/is/ moving things around behind my back -- udevadm monitor shows no
activity when I touch and unlink 'fubar'.  In theory dir_emit_dots
should have emitted a '..' entry with d_off==2 so I don't understand why
the number changes at all.

--D

> 
> -- 
> Chuck Lever
> 

